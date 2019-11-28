//
//  VisitorMainViewModel.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

protocol VisitorMainViewModelInputs {
  func pushNextViewController()
}

protocol VisitorMainViewModelOutputs {
  var isNextButtonTapped: Observable<Void> { get }
}

final class VisitorMainViewModel {
  private let isNextButtonTappedSubject = BehaviorRelay<Void?>(value: nil)
}

extension VisitorMainViewModel: VisitorMainViewModelInputs {
  func pushNextViewController() {
    isNextButtonTappedSubject.accept(Void())
  }
}

extension VisitorMainViewModel: VisitorMainViewModelOutputs {
  var isNextButtonTapped: Observable<Void> {
    return isNextButtonTappedSubject.compactMap { $0 }
  }
}
