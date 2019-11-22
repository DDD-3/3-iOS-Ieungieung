//
//  AppDelegate.swift
//  gigi
//
//  Created by Presto on 2019/11/22.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import Combine
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  private var cancellables = Set<AnyCancellable>()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    return true
  }
}

private extension AppDelegate {
  func setInitialCoordinate() {
    let service = LocationService.shared

    service.requestAuthorization()

    service.authorizationStatusPublisher
      .filter { $0 == .authorizedWhenInUse || $0 == .authorizedAlways }
      .sink(receiveValue: { _ in
        Log.debug("위치 정보 권한 허용됨")
        service.startUpdatingLocation()
      })
      .store(in: &cancellables)

    service.authorizationStatusPublisher
      .filter { !($0 == .authorizedWhenInUse || $0 == .authorizedAlways) }
      .sink(receiveValue: { _ in
        Log.error("위치 정보 권한 허용되지 않음")
      })
      .store(in: &cancellables)

    service.coordinateResultPublisher
      .compactMap { $0.success }
      .sink(receiveValue: { coordinate in
        Log.debug("현재 위치 갱신됨 : \(coordinate)")
        service.stopUpdatingLocation()
      })
      .store(in: &cancellables)

    service.coordinateResultPublisher
      .compactMap { $0.failure }
      .sink(receiveValue: { error in
        Log.error("위치 갱신 에러 : \(error.localizedDescription)")
      })
      .store(in: &cancellables)
  }
}
