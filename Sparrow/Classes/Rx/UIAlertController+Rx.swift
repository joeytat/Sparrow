//
//  UIAlertController+Rx.swift
//  Alamofire
//
//  Created by Joey on 15/12/2017.
//

import Foundation
import RxSwift

public extension Reactive where Base: UIAlertController {
  public static func presentInputAlert(by vc:UIViewController, title: String) -> Observable<String?> {
    return Observable<String?>
      .create { observer in
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
          textField.placeholder = "请输入\(title)"
          textField.becomeFirstResponder()
        })
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: { _ in
          observer.onNext(nil)
          observer.onCompleted()
        }))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
          let text = alert.textFields?.first!.text
          observer.onNext(text)
          observer.onCompleted()
        }))
        vc.present(alert, animated: true, completion: nil)
        return Disposables.create {
          alert.dismiss(animated: true, completion: nil)
        }
    }
  }
  
  public static func presentConfirmAlert(by vc: UIViewController, title: String) -> Observable<Bool> {
    return Observable<Bool>
      .create { observer in
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: { _ in
          observer.onNext(false)
          observer.onCompleted()
        }))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
          observer.onNext(true)
          observer.onCompleted()
        }))
        vc.present(alert, animated: true, completion: nil)
        return Disposables.create {
          alert.dismiss(animated: true, completion: nil)
        }
    }
  }
}
