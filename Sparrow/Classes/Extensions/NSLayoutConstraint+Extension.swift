//
//  NSLayoutConstraint+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation
import UIKit

public extension NSLayoutConstraint {
  @IBInspectable public var usePixels: Bool {
    get {
      return false
    }
    set {
      if newValue {
        constant = constant / UIScreen.main.scale
      }
    }
  }
}
