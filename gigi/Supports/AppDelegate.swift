//
//  AppDelegate.swift
//  gigi
//
//  Created by Presto on 2019/11/07.
//  Copyright © 2019 ieungieung. All rights reserved.
//

import Combine
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  private var cancellables = Set<AnyCancellable>()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setInitialCoordinate()
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication,
                   didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

extension AppDelegate {
  private func setInitialCoordinate() {
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
