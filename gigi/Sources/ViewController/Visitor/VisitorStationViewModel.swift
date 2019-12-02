//
//  VisitorStationViewModel.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

// MARK: - 명세

protocol VisitorStationViewModelProtocol {
  var input: VisitorStationViewModelInputProtocol { get }

  var output: VisitorStationViewModelOutputProtocol { get }
}

protocol VisitorStationViewModelInputProtocol {
  func inputNearStationName(_ name: String)

  func inputBackStationName(_ name: String)

  func finishStationNameInput()

  func pushNextViewController()
}

protocol VisitorStationViewModelOutputProtocol {
  var isStationNameInputFinished: Observable<Void> { get }

  var isNextButtonTapped: Observable<Void> { get }
}

// MARK: - 구현

final class VisitorStationViewModel {
  private let nearStationNameRelay = BehaviorRelay<String?>(value: nil)

  private let backStationNameRelay = BehaviorRelay<String?>(value: nil)

  private let isStationNameInputFinishedRelay = BehaviorRelay<Void?>(value: nil)

  private let isNextButtonTappedRelay = BehaviorRelay<Void?>(value: nil)
}

extension VisitorStationViewModel: VisitorStationViewModelProtocol {
  var input: VisitorStationViewModelInputProtocol { return self }

  var output: VisitorStationViewModelOutputProtocol { return self }
}

extension VisitorStationViewModel: VisitorStationViewModelInputProtocol {
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

extension VisitorStationViewModel: VisitorStationViewModelOutputProtocol {
  var isStationNameInputFinished: Observable<Void> {
    return isStationNameInputFinishedRelay.compactMap { $0 }
  }

  var isNextButtonTapped: Observable<Void> {
    return isNextButtonTappedRelay.compactMap { $0 }
  }
}
