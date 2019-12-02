//
//  StationSearchListViewModel.swift
//  gigi
//
//  Created by Presto on 2019/12/02.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

protocol StationSearchListViewModelProtocol {
  var input: StationSearchListViewModelInputProtocol { get }

  var output: StationSearchListViewModelOutputProtocol { get }
}

protocol StationSearchListViewModelInputProtocol {}

protocol StationSearchListViewModelOutputProtocol {}

final class StationSearchListViewModel {}

extension StationSearchListViewModel: StationSearchListViewModelProtocol {
  var input: StationSearchListViewModelInputProtocol { return self }

  var output: StationSearchListViewModelOutputProtocol { return self }
}

extension StationSearchListViewModel: StationSearchListViewModelInputProtocol {}

extension StationSearchListViewModel: StationSearchListViewModelOutputProtocol {}
