//
//  Optional.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation

// Get from https://gist.github.com/PaulTaykalo/2ebfe0d7c1ca9fff1938506e910f738c

public extension Optional {
  public func `or`(_ value : Wrapped?) -> Optional {
    return self ?? value
  }
  public func `or`(_ value: Wrapped) -> Wrapped {
    return self ?? value
  }
}
