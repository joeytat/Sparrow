//
//  NSLayoutConstraint+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation
import UIKit
import RxSwift
import NSObject_Rx

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
    @IBInspectable public var spaceBetweenKeybaord: Int {
        set {
            let keyboardDisplay = NotificationCenter.default.rx
                .notification(Notification.Name.UIKeyboardWillChangeFrame)
                .map { n -> CGFloat in
                    let value = (n.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                    if #available(iOS 11.0, *) {
                        let bottom = UIApplication.shared.keyWindow!.safeAreaInsets.bottom
                        return ceil(value.height) - bottom + CGFloat(newValue)
                    } else {
                        return ceil(value.height)
                    }
            }
            
            let keyboardHide = NotificationCenter.default.rx
                .notification(Notification.Name.UIKeyboardWillHide)
                .map { n in
                    return CGFloat(newValue)
            }
            
            Observable.merge(keyboardDisplay, keyboardHide)
                .subscribe(onNext: {[weak self] n in
                    self?.constant = n
                    UIView.commitAnimations()
                })
                .disposed(by: rx.disposeBag)
        }
        get {
            return 0
        }
    }
}
