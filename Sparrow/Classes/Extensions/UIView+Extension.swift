//
//  UIView+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation
import UIKit
import SnapKit

public extension UIView {
    @IBInspectable public var patternImage: UIImage? {
        set {
            guard let image = newValue else { return }
            self.backgroundColor = UIColor(patternImage: image)
        }
        get {
            guard let backgroundColor = self.backgroundColor else { return nil }
            return UIImage.from(color: backgroundColor)
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    
    @IBInspectable public var shadowColor: UIColor {
        set{
            layer.shadowColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }
    }

    @IBInspectable public var shadowRadius: CGFloat {
        set{
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
            layer.borderWidth = 1
        }
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
    }
}

public extension UIView{
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }


    public static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

}

public protocol UIViewLoading {}
extension UIView : UIViewLoading {}
public extension UIViewLoading where Self : UIView {
    public static func loadFromNib() -> Self {
        let nibName = "\(self)".split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}


// MARK: - Badge
private let kBadgeViewTag = 2333
public extension UIView {
    public var badgeNumber: Int {
        set {
            if let label = viewWithTag(kBadgeViewTag) as? UILabel {
                label.text = "\(newValue)"
                label.isHidden = newValue < 1
            } else {
                let label = UILabel()
                label.text = "\(newValue)"
                label.textColor = UIColor.white
                label.tag = kBadgeViewTag
                label.textAlignment = .center
                label.backgroundColor = UIColor.red
                label.font = UIFont.systemFont(ofSize: 12)
                
                self.addSubview(label)
                label.snp.makeConstraints{ make in
                    make.centerX.equalTo(self.snp.trailing)
                    make.centerY.equalTo(self.snp.top)
                    make.width.height.equalTo(16)
                }
                label.cornerRadius = 8
                label.isHidden = newValue < 1
            }
        }
        get {
            guard let label = viewWithTag(kBadgeViewTag) as? UILabel else {
                return 0
            }
            return Int(label.text ?? "0") ?? 0
        }
    }
}

// MARK: - Tap gesture
public extension UIView {
    @IBInspectable public var dismissOnTap: Bool {
        set {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.dismiss))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(tapGesture)
        }
        get {
            assert(false, "Do not use this getter")
            return false
        }
    }
    
    @IBInspectable public var popOnTap: Bool {
        set {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.pop))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(tapGesture)
        }
        get {
            assert(false, "Do not use this getter")
            return false
        }
    }
    
    @objc private func dismiss() {
        guard let currentVC = UIApplication.shared.keyWindow?.visibleViewController else { return }
        if let tabBar = currentVC as? UITabBarController {
            let nav = tabBar.selectedViewController as! UINavigationController
            nav.dismiss(animated: true, completion: nil)
        } else {
            currentVC.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func pop() {
        guard let currentVC = UIApplication.shared.keyWindow?.visibleViewController else { return }
        guard let nav = currentVC.navigationController else { return }
        nav.popViewController(animated: true)
    }
}

