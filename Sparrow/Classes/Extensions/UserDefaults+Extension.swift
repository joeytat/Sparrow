//
//  UserDefaults+Extension.swift
//  Sparrow
//  Created by Joey on 20/11/2017.
//

import Foundation

public struct Storage {
  public static func save(key: String, value: Any?) {
    guard let value = value else {
      UserDefaults.standard.setValue(nil, forKey: key)
      return
    }
    UserDefaults.standard.setValue(value, forKey: key)
  }
  
  public static func load(key: String) -> Any? {
    return UserDefaults.standard.value(forKey:key)
  }
}
