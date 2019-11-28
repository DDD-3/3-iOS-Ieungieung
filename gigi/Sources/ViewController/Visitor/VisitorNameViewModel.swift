//
//  VisitorNameViewModel.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

protocol VisitorNameViewModelInputs {
  func inputName(_ name: String)

  func finishNameInput()

  func pushNextViewController()
}

protocol VisitorNameViewModelOutputs {
  var isNameInputFinished: Observable<Void> { get }

  var isNextButtonTapped: Observable<Void> { get }
}

final class VisitorNameViewModel {
  private let nameRelay = BehaviorRelay<String?>(value: nil)

  private let isNameInputFinishedRelay = BehaviorRelay<Void?>(value: nil)

  private let isNextButtonTappedRelay = BehaviorRelay<Void?>(value: nil)
}

extension VisitorNameViewModel: VisitorNameViewModelInputs {
  func inputName(_ name: String) {
    nameRelay.accept(name)
  }

  func finishNameInput() {
    isNameInputFinishedRelay.accept(Void())
  }

  func pushNextViewController() {
    isNextButtonTappedRelay.accept(Void())
  }
}

extension VisitorNameViewModel: VisitorNameViewModelOutputs {
  var isNameInputFinished: Observable<Void> {
    return isNameInputFinishedRelay.compactMap { $0 }
  }

  var isNextButtonTapped: Observable<Void> {
    return isNextButtonTappedRelay.compactMap { $0 }
  }
}
