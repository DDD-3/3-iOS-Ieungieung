//
//  ParticipationViewModel.swift
//  gigi
//
//  Created by Presto on 2019/12/02.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

protocol ParticipationViewModelProtocol {
  var input: ParticipationViewModelInputProtocol { get }

  var output: ParticipationViewModelOutputProtocol { get }
}

protocol ParticipationViewModelInputProtocol {
  func presentMapViewController()
}

protocol ParticipationViewModelOutputProtocol {
  var isFindButtonTapped: Observable<Void> { get }
}

final class ParticipationViewModel {
  private let isFindButtonTappedRelay = BehaviorRelay<Void?>(value: nil)
}

extension ParticipationViewModel: ParticipationViewModelProtocol {
  var input: ParticipationViewModelInputProtocol { return self }

  var output: ParticipationViewModelOutputProtocol { return self }
}

extension ParticipationViewModel: ParticipationViewModelInputProtocol {
  func presentMapViewController() {
    isFindButtonTappedRelay.accept(Void())
  }
}

extension ParticipationViewModel: ParticipationViewModelOutputProtocol {
  var isFindButtonTapped: Observable<Void> {
    return isFindButtonTappedRelay.compactMap { $0 }
  }
}
