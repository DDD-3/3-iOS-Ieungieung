//
//  VisitorFinishViewModel.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

protocol VisitorFinishViewModelProtocol {
  var input: VisitorFinishViewModelInputProtocol { get }

  var output: VisitorFinishViewModelOutputProtocol { get }
}

protocol VisitorFinishViewModelInputProtocol {}

protocol VisitorFinishViewModelOutputProtocol {}

final class VisitorFinishViewModel {}

extension VisitorFinishViewModel: VisitorFinishViewModelProtocol {
  var input: VisitorFinishViewModelInputProtocol { return self }

  var output: VisitorFinishViewModelOutputProtocol { return self }
}

extension VisitorFinishViewModel: VisitorFinishViewModelInputProtocol {}

extension VisitorFinishViewModel: VisitorFinishViewModelOutputProtocol {}
