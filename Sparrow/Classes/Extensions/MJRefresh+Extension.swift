//
//  MJRefresh+Extension.swift
//  Viserion
//
//  Created by Joey on 21/12/2017.
//  Copyright © 2017 UOKO. All rights reserved.
//

import UIKit
import RxSwift
import MJRefresh

public enum ListData<T> {
    case initial
    case refresh([T])
    case more([T])
    case noMore([T])
    public var items: Array<T> {
        switch self {
        case .initial:
            return []
        case .more(let items), .noMore(let items), .refresh(let items):
            return items
        }
    }
}

private var kPageIndexAssociatedKey: String = "sparrow.pageIndex"
public extension Reactive where Base: UITableView {
    public var pageIndex: Variable<Int> {
        get {
            if let value = objc_getAssociatedObject(self.base, &kPageIndexAssociatedKey) as? Variable<Int> {
                return value
            } else {
                let value = Variable<Int>(1)
                objc_setAssociatedObject(self.base, &kPageIndexAssociatedKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return value
            }
        }
    }
    
    public func loading(startIndex: Int = 1) -> Observable<Int> {
        let tableView = self.base
        return Observable<Int>
            .create { observer in
                tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                    if #available(iOS 10.0, *) {
                        UINotificationFeedbackGenerator().notificationOccurred(UINotificationFeedbackType.success)
                    }
                    observer.onNext(1)
                })
                tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                    if #available(iOS 10.0, *) {
                        UINotificationFeedbackGenerator().notificationOccurred(UINotificationFeedbackType.success)
                    }
                    observer.onNext(tableView.rx.pageIndex.value)
                })
                
                let displayFooter = tableView.rx.pageIndex.asObservable()
                    .subscribe(onNext: { n in
                        tableView.mj_footer.isHidden = n == startIndex
                    })
                
                return Disposables.create {
                    displayFooter.dispose()
                    tableView.mj_header = nil
                    tableView.mj_footer = nil
                }
            }
            .share(replay: 1, scope: SubjectLifetimeScope.forever)
    }
}
