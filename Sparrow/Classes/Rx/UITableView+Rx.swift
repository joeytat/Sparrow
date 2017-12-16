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
            .observeOn(MainScheduler.asyncInstance)
            .throttle(0.1, scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged { old, new in
                switch new {
                case 1:
                    return false
                default:
                    return old == new
                }
            }
            .share()
    }
}

