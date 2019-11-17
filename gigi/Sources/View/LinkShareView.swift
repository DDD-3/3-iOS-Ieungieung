//
//  LinkShareView.swift
//  gigi
//
//  Created by Presto on 2019/11/17.
//  Copyright © 2019 ieungieung. All rights reserved.
//

import SwiftUI
import UIKit

/// 생성된 링크를 공유하기 위한 뷰.
struct LinkShareView: UIViewControllerRepresentable {
  /// 공유할 링크의 문자열 표현.
  private let urlString: String
  /// 공유 뷰가 사라질 때 실행할 핸들러.
  private let onDismiss: UIActivityViewController.CompletionWithItemsHandler?

  init(urlString: String, onDismiss: UIActivityViewController.CompletionWithItemsHandler? = nil) {
    self.urlString = urlString
    self.onDismiss = onDismiss
  }

  func makeUIViewController(context: Context) -> UIActivityViewController {
    let activityViewController = UIActivityViewController(activityItems: [urlString],
                                                          applicationActivities: nil)
    activityViewController.completionWithItemsHandler = onDismiss
    return activityViewController
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct ShareView_Previews: PreviewProvider {
  static var previews: some View {
    LinkShareView(urlString: "", onDismiss: nil)
  }
}
