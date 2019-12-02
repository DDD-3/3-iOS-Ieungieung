//
//  MapViewModel.swift
//  gigi
//
//  Created by Presto on 2019/12/02.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import RxRelay
import RxSwift

protocol MapViewModelProtocol {
  var input: MapViewModelInputProtocol { get }

  var output: MapViewModelOutputProtocol { get }
}

protocol MapViewModelInputProtocol {}

protocol MapViewModelOutputProtocol {}

final class MapViewModel {}

extension MapViewModel: MapViewModelProtocol {
  var input: MapViewModelInputProtocol { return self }

  var output: MapViewModelOutputProtocol { return self }
}

extension MapViewModel: MapViewModelInputProtocol {}

extension MapViewModel: MapViewModelOutputProtocol {}
