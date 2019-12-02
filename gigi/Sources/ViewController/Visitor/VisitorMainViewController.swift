//
//  VisitorMainViewController.swift
//  gigi
//
//  Created by Presto on 2019/11/22.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class VisitorMainViewController: GigiViewController {
  @IBOutlet private var nextButton: UIButton!
  private let tapGestureRecognizer = UITapGestureRecognizer()

  var viewModel: VisitorMainViewModelProtocol!

  override func setup() {
    navigationItem.backBarButtonItem = .init()
  }

  override func bindViewModelInputs() {
    nextButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.input.pushNextViewController()
      })
      .disposed(by: disposeBag)
  }

  override func bindViewModelOutputs() {
    viewModel.output.isNextButtonTapped
      .map {
        StoryboardScene.Visitor.visitorNameViewController.instantiate().then {
          $0.viewModel = VisitorNameViewModel()
        }
      }
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.pushViewController($0, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
