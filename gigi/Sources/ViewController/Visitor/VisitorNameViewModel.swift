//
//  VisitorNameViewModel.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

// MARK: - 명세

protocol VisitorNameViewModelProtocol {
  var input: VisitorNameViewModelInputProtocol { get }

  var output: VisitorNameViewModelOutputProtocol { get }
}

protocol VisitorNameViewModelInputProtocol {
  func inputName(_ name: String)

  func finishNameInput()

  func pushNextViewController()
}

protocol VisitorNameViewModelOutputProtocol {
  var isNameInputFinished: Observable<Void> { get }

  var isNextButtonTapped: Observable<Void> { get }
}

// MARK: - 구현

final class VisitorNameViewModel {
  private let nameRelay = BehaviorRelay<String?>(value: nil)

  private let isNameInputFinishedRelay = BehaviorRelay<Void?>(value: nil)

  private let isNextButtonTappedRelay = BehaviorRelay<Void?>(value: nil)
}

extension VisitorNameViewModel: VisitorNameViewModelProtocol {
  var input: VisitorNameViewModelInputProtocol { return self }

  var output: VisitorNameViewModelOutputProtocol { return self }
}

extension VisitorNameViewModel: VisitorNameViewModelInputProtocol {
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

extension VisitorNameViewModel: VisitorNameViewModelOutputProtocol {
  var isNameInputFinished: Observable<Void> {
    return isNameInputFinishedRelay.compactMap { $0 }
  }

  var isNextButtonTapped: Observable<Void> {
    return isNextButtonTappedRelay.compactMap { $0 }
  }
}
