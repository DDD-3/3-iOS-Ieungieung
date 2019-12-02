//
//  UIAlertController+.swift
//  gigi
//
//  Created by Presto on 2019/12/02.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxSwift

extension UIAlertController {
  static func alert(title: String?,
                    message: String?,
                    style: UIAlertController.Style = .alert) -> UIAlertController {
    return .init(title: title, message: message, preferredStyle: style)
  }

  func action(title: String?,
              style: UIAlertAction.Style = .default,
              completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    let action = UIAlertAction(title: title, style: style, handler: completion)
    addAction(action)
    return self
  }

  func textField(configuration: ((UITextField) -> Void)? = nil) -> UIAlertController {
    addTextField(configurationHandler: configuration)
    return self
  }

  func present(to viewController: UIViewController?,
               animated: Bool = true,
               completion: (() -> Void)? = nil) {
    viewController?.present(self, animated: animated, completion: completion)
  }
}
