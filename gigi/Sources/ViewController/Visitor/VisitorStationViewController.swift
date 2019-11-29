//
//  VisitorStationViewController.swift
//  gigi
//
//  Created by Presto on 2019/11/22.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class VisitorStationViewController: GigiViewController {
  @IBOutlet private var nearStationNameTextField: GigiTextField!
  @IBOutlet private var backStationNameTextField: GigiTextField!
  private var nextButton = UIBarButtonItem()
  private var tapGestureRecognizer = UITapGestureRecognizer()

  var viewModel: VisitorStationViewModelProtocol!

  override func setup() {
    nextButton.title = "다음"
    navigationItem.backBarButtonItem = .init()
    navigationItem.setRightBarButton(nextButton, animated: false)
  }

  override func bindViewModelInputs() {
    tapGestureRecognizer.rx.event
      .filter { $0.state == .ended }
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.input.finishStationNameInput()
      })
      .disposed(by: disposeBag)

    nearStationNameTextField.rx.text
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] text in
        self?.viewModel.input.inputNearStationName(text)
      })
      .disposed(by: disposeBag)

    backStationNameTextField.rx.text
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] text in
        self?.viewModel.input.inputBackStationName(text)
      })
      .disposed(by: disposeBag)

    Observable
      .concat([
        nearStationNameTextField.rx.editingDidEndOnExit.asObservable(),
        backStationNameTextField.rx.editingDidEndOnExit.asObservable(),
      ])
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.input.finishStationNameInput()
      })
      .disposed(by: disposeBag)

    nextButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.input.pushNextViewController()
      })
      .disposed(by: disposeBag)
  }

  override func bindViewModelOutputs() {
    viewModel.output.isStationNameInputFinished
      .subscribe(onNext: { [weak self] _ in
        self?.nearStationNameTextField.resignFirstResponder()
        self?.backStationNameTextField.resignFirstResponder()
      })
      .disposed(by: disposeBag)

    viewModel.output.isNextButtonTapped
      .map { StoryboardScene.Visitor.visitorFinishViewController.instantiate() }
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.pushViewController($0, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
