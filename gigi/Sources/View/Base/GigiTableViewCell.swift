//
//  GigiTableViewCell.swift
//  gigi
//
//  Created by Presto on 2019/12/02.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxSwift

class GigiTableViewCell: UITableViewCell {
  private(set) var disposeBag = DisposeBag()

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
    bind()
  }

  func setup() {}

  func bind() {}
}
