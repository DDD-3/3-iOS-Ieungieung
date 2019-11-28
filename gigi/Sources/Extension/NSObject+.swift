//
//  NSObject+.swift
//  gigi
//
//  Created by Presto on 2019/11/22.
//  Copyright © 2019 Ieungieung. All rights reserved.
//

import Foundation

extension NSObject {
  var name: String {
    return NSStringFromClass(type(of: self))
  }

  static var name: String {
    return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
  }
}
