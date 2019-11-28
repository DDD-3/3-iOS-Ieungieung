//
//  LocationService.swift
//  gigi
//
//  Created by Presto on 2019/11/22.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import CoreLocation

import RxRelay
import RxSwift

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
    guard let result = locationManagerDelegateObject.coordinateResultRelay.value
    else { return nil }
    return result
  }

  var authorizationStatusObservable: Observable<CLAuthorizationStatus> {
    return locationManagerDelegateObject.authorizationStatusRelay
      .compactMap { $0 }
  }

  var coordinateResultObservable: Observable<CoordinateResult> {
    return locationManagerDelegateObject.coordinateResultRelay
      .compactMap { $0 }
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
  let authorizationStatusRelay = BehaviorRelay<CLAuthorizationStatus?>(value: nil)

  let coordinateResultRelay = BehaviorRelay<CoordinateResult?>(value: nil)

  func locationManager(_ manager: CLLocationManager,
                       didChangeAuthorization status: CLAuthorizationStatus) {
    authorizationStatusRelay.accept(status)
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    coordinateResultRelay.accept(.success(location.coordinate))
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    guard let clError = error as? CLError else { return }
    coordinateResultRelay.accept(.failure(clError))
  }
}
