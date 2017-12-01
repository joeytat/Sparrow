//
//  UITableView+Extension.swift
//  Alamofire
//
//  Created by Joey on 01/12/2017.
//

import Foundation

private var kEmptyImageViewKey: Void?
private var kEmptyContainerViewKey: Void?
private var kEmptyLabelKey: Void?
public extension UITableView {
    public var emptyContainerView: UIStackView {
        get {
            if let container = objc_getAssociatedObject(self, &kEmptyContainerViewKey) as? UIStackView {
                return container
            } else {
                let stackView = UIStackView(arrangedSubviews: [emptyImageView, emptyLabel])
                stackView.alignment = .center
                stackView.axis = .vertical
                stackView.spacing = 20
                addSubview(stackView)
                stackView.snp.makeConstraints { make in
                    make.center.equalTo(self)
                }
                objc_setAssociatedObject(self, &kEmptyContainerViewKey, stackView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return stackView
            }
        }
    }
    public var emptyImageView: UIImageView {
        get {
            if let imageView = objc_getAssociatedObject(self, &kEmptyImageViewKey) as? UIImageView {
                return imageView
            } else {
                let imageView = UIImageView()
                objc_setAssociatedObject(self, &kEmptyImageViewKey, imageView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                let _ = emptyContainerView
                return imageView
            }
        }
    }
    public var emptyLabel: UILabel {
        get {
            if let label = objc_getAssociatedObject(self, &kEmptyLabelKey) as? UILabel {
                return label
            } else {
                let label = UILabel()
                objc_setAssociatedObject(self, &kEmptyLabelKey, label, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                let _ = emptyContainerView
                return label
            }
        }
    }
}
