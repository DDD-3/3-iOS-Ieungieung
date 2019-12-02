//
//  GigiViewController.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxSwift

class GigiViewController: UIViewController {
  private(set) var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bindViewModelInputs()
    bindViewModelOutputs()
  }

  func setup() {}

  func bindViewModelInputs() {}

  func bindViewModelOutputs() {}
}
