//
//  VisitorNameViewController.swift
//  gigi
//
//  Created by Presto on 2019/11/22.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class VisitorNameViewController: GigiViewController {
  @IBOutlet private var nameTextField: GigiTextField!
  private var nextButton = UIBarButtonItem()

  private let viewModel = VisitorNameViewModel()

  override func setup() {
    nextButton.title = "다음"
    navigationItem.backBarButtonItem = .init()
    navigationItem.setRightBarButton(nextButton, animated: false)
  }

  override func bind() {
    nameTextField.rx.text
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] text in
        self?.viewModel.inputName(text)
      })
      .disposed(by: disposeBag)

    nameTextField.rx.editingDidEndOnExit
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.finishNameInput()
      })
      .disposed(by: disposeBag)

    nextButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.pushNextViewController()
      })
      .disposed(by: disposeBag)

    viewModel.isNameInputFinished
      .subscribe(onNext: { [weak self] _ in
        self?.nameTextField.resignFirstResponder()
      })
      .disposed(by: disposeBag)

    viewModel.isNextButtonTapped
      .map { StoryboardScene.Visitor.visitorStationViewController.instantiate() }
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.pushViewController($0, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
