//
//  KakaoMapView.swift
//  gigi
//
//  Created by Presto on 2019/11/17.
//  Copyright © 2019 ieungieung. All rights reserved.
//

import SwiftUI

/// 카카오 맵뷰.
struct KakaoMapView: UIViewRepresentable {
  func makeUIView(context: Context) -> KakaoMapUIView {
    return KakaoMapUIView()
  }

  func updateUIView(_ uiView: KakaoMapUIView, context: Context) {}

  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
}

// MARK: - Coordinator 객체

extension KakaoMapView {
  final class Coordinator: NSObject {
    private let parent: KakaoMapView

    init(parent: KakaoMapView) {
      self.parent = parent
    }
  }
}

// MARK: - MTMapViewDelegate 구현

extension KakaoMapView.Coordinator: MTMapViewDelegate {
  func mapView(_ mapView: MTMapView!,
               openAPIKeyAuthenticationResultCode resultCode: Int32,
               resultMessage: String!) {
    if resultCode == 200 {
      Log.debug("API Key 초기화 성공")
    } else {
      Log.error("API Key 초기화 실패 : \(String(describing: resultMessage))")
    }
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    KakaoMapView()
  }
}
