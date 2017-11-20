//
//  Optional.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation

public extension Optional where Wrapped == String {
  public var orEmpty: String {
    get {
      guard let str = self else { return "" }
      return str
    }
  }
}

protocol NumericOptional {
  associatedtype Value: Numeric
  var orZero: Value { get }
}


public extension Optional where Wrapped == Int {
  public var orZero: Int {
    get {
      guard let num = self else { return 0 }
      return num
    }
  }
}


public extension Optional where Wrapped == Float {
  public var orZero: Float {
    get {
      guard let num = self else { return 0 }
      return num
    }
  }
}

public extension Optional where Wrapped == Double {
  var orZero: Double {
    get {
      guard let num = self else { return 0.0 }
      return num
    }
  }
}
