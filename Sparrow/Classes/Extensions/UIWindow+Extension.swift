//
//  UserDefaults+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation

public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

// MARK: - Loading HUD
private struct AssociatedKeys {
    static var loadingView = "sparrow.loadingView"
    static var semaphore = "sparrow.semaphore"
    static var loadingKeys = "sparrow.loadingKey"
    static var imageView = "sparrow.imageView"
    static var loadingActivity = "sparrow.loadingActivity"
    
}

public extension UIWindow {
    public var loadingView: UIView {
        get {
            if let view = objc_getAssociatedObject(self, &AssociatedKeys.loadingView) as? UIView {
                self.bringSubview(toFront: view)
                return view
            } else {
                let view = UIView()
                view.backgroundColor = UIColor(hue:0.00, saturation:0.00, brightness:0.6, alpha:0.7)
                view.isUserInteractionEnabled = false
                view.alpha = 0.0
                view.cornerRadius = 4
                
                view.addSubview(loadingImageView)
                view.addSubview(loadingActivityView)
                
                loadingActivityView.snp.makeConstraints { make in
                    make.center.equalTo(view)
                }
                
                loadingImageView.snp.makeConstraints{ make in
                    make.size.equalTo(60)
                    make.center.equalTo(view)
                }
                
                UIApplication.shared.keyWindow?.addSubview(view)
                
                view.snp.makeConstraints { make in
                    make.center.equalTo(view.superview!)
                    make.size.equalTo(70)
                }
                objc_setAssociatedObject(self, &AssociatedKeys.loadingView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
        }
    }
    
    public var loadingImageView: UIImageView {
        get {
            if let imageView = objc_getAssociatedObject(self, &AssociatedKeys.imageView) as? UIImageView {
                return imageView
            } else {
                let imageView = UIImageView()
                objc_setAssociatedObject(self, &AssociatedKeys.imageView, imageView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return imageView
            }
        }
    }
    
    public var loadingActivityView: UIActivityIndicatorView {
        get {
            if let view = objc_getAssociatedObject(self, &AssociatedKeys.loadingActivity) as? UIActivityIndicatorView {
                return view
            } else {
                let view = UIActivityIndicatorView(activityIndicatorStyle: .white)
                view.startAnimating()
                
                objc_setAssociatedObject(self, &AssociatedKeys.loadingActivity, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
        }
    }
    private var hideLoadingWorkItem: DispatchWorkItem {
        get {
            if let group = objc_getAssociatedObject(self, &AssociatedKeys.semaphore) as? DispatchWorkItem {
                return group
            } else {
                let workItem = DispatchWorkItem {
                    UIView.animate(withDuration: 0.15, animations: {
                        self.loadingView.alpha = 0.0
                    })
                }
                objc_setAssociatedObject(self, &AssociatedKeys.semaphore, workItem, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return workItem
            }
        }
    }
    
    private var loadingKeys: [String] {
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.loadingKeys) as? [String] {
                return value
            } else {
                objc_setAssociatedObject(self, &AssociatedKeys.loadingKeys, [], .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return []
            }
        } set {
            objc_setAssociatedObject(self, &AssociatedKeys.loadingKeys, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func displayLoading(immediatly: Bool = false) {
        let key = UUID().uuidString
        objc_sync_enter(self)
        self.loadingKeys.append(key)
        objc_sync_exit(self)
        if immediatly {
            UIView.animate(withDuration: 0.15) {
                self.loadingView.alpha = 1.0
            }
        } else {
            delay(0.15) {
                if self.loadingKeys.contains(key) {
                    UIView.animate(withDuration: 0.15) {
                        self.loadingView.alpha = 1.0
                    }
                }
            }
        }
    }
    
    public func hideLoading() {
        objc_sync_enter(self)
        if !self.loadingKeys.isEmpty {
            self.loadingKeys.remove(at: 0)
        }
        objc_sync_exit(self)
        if self.loadingKeys.isEmpty {
            UIView.animate(withDuration: 0.15, animations: {
                self.loadingView.alpha = 0.0
            })
        }
    }
    
}
