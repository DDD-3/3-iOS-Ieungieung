//
//  ViewController.swift
//  gigi
//
//  Created by Presto on 2019/11/22.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let mapView = KakaoMapView()
    mapView.frame = view.bounds
    view.addSubview(mapView)
  }
}
