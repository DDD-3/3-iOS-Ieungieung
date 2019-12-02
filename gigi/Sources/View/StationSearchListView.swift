//
//  StationSearchListView.swift
//  gigi
//
//  Created by Presto on 2019/12/02.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class StationSearchListView: GigiView {
  @IBOutlet private var tableView: UITableView!

  override func setup() {
    tableView.rowHeight = 62
  }

  override func bind() {}
}
