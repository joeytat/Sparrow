//
//  UIButton+Extension.swift
//  Sparrow
//
//  Created by uoko on 2018/8/10.
//


import UIKit

public extension UIButton {
    @IBInspectable public var centerVertically: CGFloat {
        set {
            guard let currentImage = currentImage else { return }
            guard let currentTitle = currentTitle as NSString? else { return }
            guard let titleLabel = titleLabel else { return }
            
            let halfSpace = (newValue / 2.0)
            let halfImageWidth = (currentImage.size.width / 2.0)
            let halfImageHeight = (currentImage.size.height / 2.0)
            titleEdgeInsets = UIEdgeInsetsMake(
                halfImageHeight + halfSpace,
                -halfImageWidth,
                -halfImageHeight - halfSpace,
                halfImageWidth
            )
            
            let titleBounds = currentTitle.size(withAttributes: [.font: titleLabel.font])
            let halfEdgeWidth = (titleBounds.width / 2.0)
            let halfEdgeHeight = (titleBounds.height / 2.0)
            imageEdgeInsets = UIEdgeInsetsMake(
                -halfEdgeHeight - halfSpace,
                halfEdgeWidth,
                halfEdgeHeight + halfSpace,
                -halfEdgeWidth
            )
        }
        get {
            return 1
        }
    }
}
