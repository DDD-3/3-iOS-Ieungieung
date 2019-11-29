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
  private var tapGestureRecognizer = UITapGestureRecognizer()

  var viewModel: VisitorNameViewModelProtocol!

  override func setup() {
    view.addGestureRecognizer(tapGestureRecognizer)

    nextButton.title = "다음"
    navigationItem.backBarButtonItem = .init()
    navigationItem.setRightBarButton(nextButton, animated: false)
  }

  override func bindViewModelInputs() {
    tapGestureRecognizer.rx.event
      .filter { $0.state == .ended }
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.input.finishNameInput()
      })
      .disposed(by: disposeBag)

    nameTextField.rx.text
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] text in
        self?.viewModel.input.inputName(text)
      })
      .disposed(by: disposeBag)

    nameTextField.rx.editingDidEndOnExit
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.input.finishNameInput()
      })
      .disposed(by: disposeBag)

    nextButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.input.pushNextViewController()
      })
      .disposed(by: disposeBag)
  }

  override func bindViewModelOutputs() {
    viewModel.output.isNameInputFinished
      .subscribe(onNext: { [weak self] _ in
        self?.nameTextField.resignFirstResponder()
      })
      .disposed(by: disposeBag)

    viewModel.output.isNextButtonTapped
      .map {
        StoryboardScene.Visitor.visitorStationViewController.instantiate().then {
          $0.viewModel = VisitorStationViewModel()
        }
      }
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.pushViewController($0, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
