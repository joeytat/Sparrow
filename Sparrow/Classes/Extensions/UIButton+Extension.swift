//
//  UIButton+Extension.swift
//  Sparrow
//
//  Created by uoko on 2018/8/10.
//


import UIKit

public extension UIButton {
  @IBInspectable var centerVertically: CGFloat {
    set {
      guard let currentImage = currentImage else { return }
      guard let currentTitle = currentTitle as NSString? else { return }
      guard let titleLabel = titleLabel else { return }
      guard let font = titleLabel.font else { return }
      
      let halfSpace = (newValue / 2.0)
      let halfImageWidth = (currentImage.size.width / 2.0)
      let halfImageHeight = (currentImage.size.height / 2.0)
      titleEdgeInsets = UIEdgeInsets(
        top: halfImageHeight + halfSpace,
        left: -halfImageWidth,
        bottom: -halfImageHeight - halfSpace,
        right: halfImageWidth
      )
      
      let titleBounds = currentTitle.size(withAttributes: [.font: font])
      let halfEdgeWidth = (titleBounds.width / 2.0)
      let halfEdgeHeight = (titleBounds.height / 2.0)
      imageEdgeInsets = UIEdgeInsets(
        top: -halfEdgeHeight - halfSpace,
        left: halfEdgeWidth,
        bottom: halfEdgeHeight + halfSpace,
        right: -halfEdgeWidth
      )
      let contentOffset = titleBounds.height + newValue
      contentEdgeInsets = UIEdgeInsets(top: contentOffset / 2,
                                       left: -titleBounds.width / 2,
                                       bottom: contentOffset / 2,
                                       right: -titleBounds.width / 2)
    }
    get {
      return 1
    }
  }
}
