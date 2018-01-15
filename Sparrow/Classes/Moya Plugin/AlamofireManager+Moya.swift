//
//  AlamofireManager.swift
//  TicketSystem
//
//  Created by Joey on 21/12/2017.
//  Copyright © 2017 UOKO. All rights reserved.
//

import Foundation
import Alamofire

public class DefaultAlamofireManager: Alamofire.SessionManager {
    public static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 50
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
