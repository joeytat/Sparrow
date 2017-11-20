//
//  Thread.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation

public func delay(_ delay: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
