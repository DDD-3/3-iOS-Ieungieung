//
//  GigiTextField.swift
//  gigi
//
//  Created by Presto on 2019/11/28.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

@IBDesignable
final class GigiTextField: UIView {
  fileprivate let textField = UITextField()
  private let separatorView = UIView()

  @IBInspectable var placeholder: String? {
    get {
      return textField.placeholder
    }
    set {
      textField.placeholder = newValue
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  convenience init(placeholder: String?) {
    self.init(frame: .zero)
    self.placeholder = placeholder
  }

  @discardableResult
  override func resignFirstResponder() -> Bool {
    textField.resignFirstResponder()
    return super.resignFirstResponder()
  }
}

// MARK: - Private Method

private extension GigiTextField {
  func setup() {
    setupProperties()
    setupLayouts()
  }

  func setupProperties() {
    textField.font = .systemFont(ofSize: 22)
    separatorView.backgroundColor = Asset.separator.color
  }

  func setupLayouts() {
    addSubviews(textField, separatorView)

    textField.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }

    separatorView.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(2)
    }
  }
}

// MARK: - Reactive Extension

extension Reactive where Base: GigiTextField {
  var text: ControlProperty<String?> {
    return base.textField.rx.text
  }

  var editingDidEndOnExit: ControlEvent<Void> {
    return base.textField.rx.controlEvent(.editingDidEndOnExit)
  }
}
