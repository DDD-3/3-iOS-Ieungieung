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

  private let viewModel = VisitorMainViewModel()

  override func bind() {
    nextButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.pushNextViewController()
      })
      .disposed(by: disposeBag)

    viewModel.isNextButtonTapped
      .map { StoryboardScene.Visitor.visitorNameViewController.instantiate() }
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.pushViewController($0, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
