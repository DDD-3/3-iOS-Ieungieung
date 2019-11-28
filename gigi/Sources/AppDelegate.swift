//
//  AppDelegate.swift
//  gigi
//
//  Created by Presto on 2019/11/22.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxSwift
import Then

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  private var disposeBag = DisposeBag()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UINavigationBar.appearance().do {
      $0.setBackgroundImage(.init(), for: .default)
      $0.shadowImage = .init()
      $0.isTranslucent = true
    }
    return true
  }
}

private extension AppDelegate {
  func setInitialCoordinate() {
    let service = LocationService.shared

    service.requestAuthorization()

    service.authorizationStatusObservable
      .filter { $0 == .authorizedWhenInUse || $0 == .authorizedAlways }
      .subscribe(onNext: { _ in
        Log.debug("위치 정보 권한 허용됨")
        service.startUpdatingLocation()
      })
      .disposed(by: disposeBag)

    service.authorizationStatusObservable
      .filter { !($0 == .authorizedWhenInUse || $0 == .authorizedAlways) }
      .subscribe(onNext: { _ in
        Log.error("위치 정보 권한 허용되지 않음")
      })
      .disposed(by: disposeBag)

    service.coordinateResultObservable
      .compactMap { $0.success }
      .subscribe(onNext: { coordinate in
        Log.debug("현재 위치 갱신됨 : \(coordinate)")
        service.stopUpdatingLocation()
      })
      .disposed(by: disposeBag)

    service.coordinateResultObservable
      .compactMap { $0.failure }
      .subscribe(onNext: { error in
        Log.error("위치 갱신 에러 : \(error.localizedDescription)")
      })
      .disposed(by: disposeBag)
  }
}
