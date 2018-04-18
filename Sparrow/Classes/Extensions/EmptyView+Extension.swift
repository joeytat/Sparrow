//
//  EmptyView+Extension.swift
//  Sparrow
//
//  Created by Joey on 2018/4/18.
//

import Foundation

private var kEmptyImageViewKey: Void?
private var kEmptyContainerViewKey: Void?
private var kEmptyLabelKey: Void?
private var kEmptyButtonKey: Void?


public protocol EmptyView {
    var emptyContainerView: UIStackView { get }
    var emptyImageView: UIImageView { get }
    var emptyLabel: UILabel { get }
    var emptyButton: UIButton { get }
    /// EmptyView protocol
    var container: UIView { get }
}

public extension EmptyView {
    public var emptyContainerView: UIStackView {
        get {
            if let container = objc_getAssociatedObject(self, &kEmptyContainerViewKey) as? UIStackView {
                return container
            } else {
                let stackView = UIStackView(arrangedSubviews: [emptyImageView, emptyLabel, emptyButton])
                stackView.alignment = .center
                stackView.axis = .vertical
                stackView.spacing = 20
                container.addSubview(stackView)
                stackView.snp.makeConstraints { make in
                    make.center.equalTo(container)
                    make.width.equalTo(container).offset(-100)
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

    public var emptyButton: UIButton {
        get {
            if let button = objc_getAssociatedObject(self, &kEmptyButtonKey) as? UIButton {
                return button
            } else {
                let button = UIButton(type: .custom)
                objc_setAssociatedObject(self, &kEmptyButtonKey, button, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                let _ = emptyContainerView
                return button
            }
        }
    }
}

extension UITableView: EmptyView {
    public var container: UIView {
        get {
            return self
        }
    }
}

extension UICollectionView: EmptyView {
    public var container: UIView {
        get {
            return self
        }
    }
}
