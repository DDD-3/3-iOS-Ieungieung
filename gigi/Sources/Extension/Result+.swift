//
//  Result+.swift
//  gigi
//
//  Created by Presto on 2019/11/18.
//  Copyright © 2019 ieungieung. All rights reserved.
//

extension Result {
  var success: Success? {
    guard case let .success(success) = self else { return nil }
    return success
  }

  var failure: Failure? {
    guard case let .failure(failure) = self else { return nil }
    return failure
  }
}
