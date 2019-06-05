//
//  LoadingPlugin.swift
//  Alamofire
//
//  Created by Joey on 15/12/2017.
//

import Foundation
import Moya
import UIKit
import Result

public class LoadingPlugin: PluginType {
  
  public init() {}
  
  public func willSend(_ request: RequestType, target: TargetType) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    guard let window = UIApplication.shared.keyWindow else { return }
    window.displayLoading()
  }
  
  public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    
    guard let window = UIApplication.shared.keyWindow else { return }
    window.hideLoading()
  }
}
