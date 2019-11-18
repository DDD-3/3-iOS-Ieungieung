//
//  LocationService.swift
//  gigi
//
//  Created by Presto on 2019/11/18.
//  Copyright © 2019 ieungieung. All rights reserved.
//

import Combine
import CoreLocation

typealias CoordinateResult = Result<CLLocationCoordinate2D, CLError>

final class LocationService: NSObject {
  static let shared = LocationService()

  private let locationManagerDelegateObject = LocationManagerDelegateObject()

  private let locationManager: CLLocationManager = {
    let manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.distanceFilter = kCLDistanceFilterNone
    return manager
  }()

  private override init() {
    super.init()
    locationManager.delegate = locationManagerDelegateObject
  }

  var authorizationStatus: CLAuthorizationStatus {
    return CLLocationManager.authorizationStatus()
  }

  var coordinateResult: CoordinateResult? {
    guard let result = locationManagerDelegateObject.coordinateResultSubject.value
    else { return nil }
    return result
  }

  var authorizationStatusPublisher: AnyPublisher<CLAuthorizationStatus, Never> {
    return locationManagerDelegateObject.authorizationStatusSubject
      .compactMap { $0 }
      .eraseToAnyPublisher()
  }

  var coordinateResultPublisher: AnyPublisher<CoordinateResult, Never> {
    return locationManagerDelegateObject.coordinateResultSubject
      .compactMap { $0 }
      .eraseToAnyPublisher()
  }

  func requestAuthorization() {
    locationManager.requestWhenInUseAuthorization()
  }

  func startUpdatingLocation() {
    locationManager.startUpdatingLocation()
  }

  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
  }
}

// MARK: - Location Manager Delegate Object

private final class LocationManagerDelegateObject: NSObject, CLLocationManagerDelegate {
  let authorizationStatusSubject = CurrentValueSubject<CLAuthorizationStatus?, Never>(nil)

  let coordinateResultSubject = CurrentValueSubject<CoordinateResult?, Never>(nil)

  func locationManager(_ manager: CLLocationManager,
                       didChangeAuthorization status: CLAuthorizationStatus) {
    authorizationStatusSubject.send(status)
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    coordinateResultSubject.send(.success(location.coordinate))
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    guard let clError = error as? CLError else { return }
    coordinateResultSubject.send(.failure(clError))
  }
}
