//
//  UITableView+Extension.swift
//  Alamofire
//
//  Created by Joey on 01/12/2017.
//

import Foundation


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

