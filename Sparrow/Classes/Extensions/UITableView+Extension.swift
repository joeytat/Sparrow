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

    public func updateState<T>(_ n: ListData<T>, emptyMsg: String) {
        switch n {
        case .initial:
            self.emptyLabel.text = "加载中...( ･᷄ὢ･᷅ )"
        case .refresh:
            self.rx.pageIndex.value = 2
            self.mj_header.endRefreshing()
            self.mj_footer.resetNoMoreData()
        case .more:
            self.rx.pageIndex.value += 1
            self.mj_footer.endRefreshing()
        case .noMore:
            self.mj_header.endRefreshing()
            self.mj_footer.endRefreshingWithNoMoreData()

            if n.items.count == 0 {
                self.emptyLabel.text = emptyMsg
                self.mj_footer.isHidden = true
            } else {
                self.mj_footer.isHidden = false
            }
        }
        self.emptyContainerView.isHidden = n.items.count > 0
    }

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
                    make.width.equalTo(self).offset(-30)
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

public extension UITableView {
    public func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
    
    public var rowCount: Int {
        get {
            let sectionCount = self.numberOfSections
            let rowCount = Array(repeating: 0, count: sectionCount).reduce(0) { acc, nextSectionIndex in
                return acc + self.numberOfRows(inSection: nextSectionIndex)
            }
            return rowCount
        }
    }
}

