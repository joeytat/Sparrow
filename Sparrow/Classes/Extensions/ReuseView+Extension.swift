//
//  ReuseView+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation
import UIKit

public protocol ReusableView: class {
  static var reuseIdentifier: String {get}
}

public extension ReusableView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}

public extension UITableView {
  public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    return cell
  }
}
