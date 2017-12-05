//
//  UITableView+Rx.swift
//  Sparrow
//
//  Created by Joey on 27/11/2017.
//

import Foundation
import RxSwift
import RxCocoa

public enum TableLoadingType {
    case refresh
    case next
    case none
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

public extension Reactive where Base: UITableView {
    
    public func onNextPage(pageSize: Int) -> Observable<Int> {
        let tableView = self.base
        let loading = self.base.rx.contentOffset
            .map {[unowned tableView]_ -> TableLoadingType in
                if tableView.contentOffset.y < -20 {
                    return .refresh
                } else if tableView.isNearBottomEdge() {
                    return .next
                } else {
                    return .none
                }
            }
            .distinctUntilChanged()
        
        return loading
            .scan(1) {[unowned tableView] acc, type in
                switch type {
                case .refresh:
                    return 1
                case .next:
                    return Int(Float(tableView.rowCount) / Float(pageSize) + 0.5) + 1
                case .none:
                    return acc
                }
            }
            .distinctUntilChanged()
            .share()
    }
}
