//
//  StationSearchListCell.swift
//  gigi
//
//  Created by Presto on 2019/12/02.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

final class StationSearchListCell: GigiTableViewCell {
  @IBOutlet private var stationNameLabel: UILabel!
  @IBOutlet private var stationsLineImageStackView: UIStackView!

  func configure(with station: StationSearchBySubwayResponse.SubwayLineInfo.Station) {
    stationNameLabel.text = station.name
  }
}
