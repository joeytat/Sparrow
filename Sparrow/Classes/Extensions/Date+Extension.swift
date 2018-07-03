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
            return Calendar.current.startOfDay(for: self)
        }
    }
    
    public var endOfTheDay: Date {
        get {
            let hours = Calendar.current.date(byAdding: .hour, value: 23, to: startOfTheDay)!
            return Calendar.current.date(byAdding: .minute, value: 59, to: hours)!
        }
    }
    
    public var pretty: String {
        let now = Date().endOfTheDay
        let day: TimeInterval = 60 * 60 * 24
        let hourStr = self.format(with: "hh:mm")
        if now.timeIntervalSince1970 - self.timeIntervalSince1970 > (day * 7) {
            return format(with: "yyyy 年 MM 月 dd 日 hh:mm")
        } else if now.timeIntervalSince1970 - self.timeIntervalSince1970 > (day * 2) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.weekday], from: self)
            let format = NumberFormatter()
            format.numberStyle = NumberFormatter.Style.spellOut
            let weekday = format.string(from: NSNumber.init(value: components.weekday.or(0))).orEmpty
            return "星期\(weekday) \(hourStr)"
        } else if now.timeIntervalSince1970 - self.timeIntervalSince1970 > day {
            return "昨天 \(hourStr)"
        } else {
            return hourStr
        }
    }
    
    public func next(day: Int) -> Date {
        let date = Calendar.current.date(byAdding: .day, value: day, to: self)!
        return date
    }
    
}


