//
//  ParticipationViewController.swift
//  gigi
//
//  Created by Presto on 2019/12/02.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class ParticipationViewController: GigiViewController {
  @IBOutlet private var participationCountLabel: UILabel!
  @IBOutlet private var tableView: UITableView!
  @IBOutlet private var findButton: UIButton!

  var viewModel: ParticipationViewModelProtocol!

  override func setup() {
    tableView.do {
      $0.contentInset = .init(top: 0, left: 30, bottom: 0, right: 30)
    }
  }

  override func bind() {
    findButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.viewModel.input.presentMapViewController()
      })
      .disposed(by: disposeBag)

    viewModel.output.isFindButtonTapped
      .map {
        StoryboardScene.Map.mapViewController.instantiate().then {
          $0.modalTransitionStyle = .flipHorizontal
        }
      }
      .subscribe(onNext: { [weak self] in
        self?.present($0, animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
  }
}
