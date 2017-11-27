//
//  Date+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation

public extension TimeInterval {
    public func formatedDate(with format: String = "yyyy 年 MM 月 dd 日 HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}


public extension Date {
    
    public func format(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public var startOfTheDay: Date {
        get {
            return Calendar.current.startOfDay(for: Date())
        }
    }
    
    public var endOfTheDay: Date {
        get {
            let hours = Calendar.current.date(byAdding: .hour, value: 23, to: startOfTheDay)!
            return Calendar.current.date(byAdding: .minute, value: 59, to: hours)!
        }
    }
}


