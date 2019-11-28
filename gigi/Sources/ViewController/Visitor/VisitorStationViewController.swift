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
  @IBOutlet private var nearStationNameTextField: UITextField!
  @IBOutlet private var backStationNameTextField: UITextField!
  private var nextButton = UIBarButtonItem()

  private let viewModel = VisitorStationViewModel()

  override func setup() {
    nextButton.title = "다음"
    navigationItem.setRightBarButton(nextButton, animated: false)
  }

  override func bind() {
    nearStationNameTextField.rx.text
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] text in
        self?.viewModel.inputNearStationName(text)
      })
      .disposed(by: disposeBag)

    backStationNameTextField.rx.text
      .compactMap { $0 }
      .subscribe(onNext: { [weak self] text in
        self?.viewModel.inputBackStationName(text)
      })
      .disposed(by: disposeBag)

    Observable
      .concat([
        nearStationNameTextField.rx.controlEvent(.editingDidEndOnExit).asObservable(),
        backStationNameTextField.rx.controlEvent(.editingDidEndOnExit).asObservable(),
      ])
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.finishStationNameInput()
      })
      .disposed(by: disposeBag)

    nextButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.pushNextViewController()
      })
      .disposed(by: disposeBag)

    viewModel.isStationNameInputFinished
      .subscribe(onNext: { [weak self] _ in
        self?.nearStationNameTextField.resignFirstResponder()
        self?.backStationNameTextField.resignFirstResponder()
      })
      .disposed(by: disposeBag)

    viewModel.isNextButtonTapped
      .map { StoryboardScene.Visitor.visitorFinishViewController.instantiate() }
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.pushViewController($0, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
