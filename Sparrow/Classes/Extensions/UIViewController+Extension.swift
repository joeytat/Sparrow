//
//  UIViewController+Extension.swift
//  Alamofire
//
//  Created by Joey on 23/03/2018.
//

import Foundation
import Toast_Swift

public extension UIViewController {
    public enum MessageType {
        case warning, success, info
    }
    public func show(_ message: String, type: MessageType = .info) {
        self.view.hideToast()
        self.view.makeToast(message,
                            duration: 1.5,
                            position: .top,
                            completion: nil)
    }
}
