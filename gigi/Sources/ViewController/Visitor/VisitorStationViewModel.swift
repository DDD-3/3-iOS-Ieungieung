//
//  VisitorStationViewModel.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

protocol VisitorStationViewModelInputs {
  func inputNearStationName(_ name: String)

  func inputBackStationName(_ name: String)

  func finishStationNameInput()

  func pushNextViewController()
}

protocol VisitorStationViewModelOutputs {
  var isStationNameInputFinished: Observable<Void> { get }

  var isNextButtonTapped: Observable<Void> { get }
}

final class VisitorStationViewModel {
  private let nearStationNameRelay = BehaviorRelay<String?>(value: nil)

  private let backStationNameRelay = BehaviorRelay<String?>(value: nil)

  private let isStationNameInputFinishedRelay = BehaviorRelay<Void?>(value: nil)

  private let isNextButtonTappedRelay = BehaviorRelay<Void?>(value: nil)
}

extension VisitorStationViewModel: VisitorStationViewModelInputs {
  func inputNearStationName(_ name: String) {
    nearStationNameRelay.accept(name)
  }

  func inputBackStationName(_ name: String) {
    backStationNameRelay.accept(name)
  }

  func finishStationNameInput() {
    isStationNameInputFinishedRelay.accept(Void())
  }

  func pushNextViewController() {
    isNextButtonTappedRelay.accept(Void())
  }
}

extension VisitorStationViewModel: VisitorStationViewModelOutputs {
  var isStationNameInputFinished: Observable<Void> {
    return isStationNameInputFinishedRelay.compactMap { $0 }
  }

  var isNextButtonTapped: Observable<Void> {
    return isNextButtonTappedRelay.compactMap { $0 }
  }
}
