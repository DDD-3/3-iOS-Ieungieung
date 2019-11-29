//
//  VisitorMainViewModel.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

// MARK: - 명세

protocol VisitorMainViewModelProtocol {
  var input: VisitorMainViewModelInputProtocol { get }

  var output: VisitorMainViewModelOutputProtocol { get }
}

protocol VisitorMainViewModelInputProtocol {
  func pushNextViewController()
}

protocol VisitorMainViewModelOutputProtocol {
  var isNextButtonTapped: Observable<Void> { get }
}

// MARK: - 구현

final class VisitorMainViewModel {
  private let isNextButtonTappedSubject = BehaviorRelay<Void?>(value: nil)
}

extension VisitorMainViewModel: VisitorMainViewModelProtocol {
  var input: VisitorMainViewModelInputProtocol { return self }

  var output: VisitorMainViewModelOutputProtocol { return self }
}

extension VisitorMainViewModel: VisitorMainViewModelInputProtocol {
  func pushNextViewController() {
    isNextButtonTappedSubject.accept(Void())
  }
}

extension VisitorMainViewModel: VisitorMainViewModelOutputProtocol {
  var isNextButtonTapped: Observable<Void> {
    return isNextButtonTappedSubject.compactMap { $0 }
  }
}
