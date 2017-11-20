//
//  UIWindow+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation
import UIKit

public extension UIScreen {
    @nonobjc public  class var width: CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    @nonobjc public class var height: CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
}
