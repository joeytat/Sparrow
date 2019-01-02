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
    
    public func pretty(displayJustNow: Bool = false) -> String {
        let now = Date().timeIntervalSince1970
        let calendar = Calendar.current
        
        if displayJustNow, now - timeIntervalSince1970 < 60 {
            return "刚刚"
        } else if now - timeIntervalSince1970 < 60 * 60 && calendar.isDateInToday(self) {
            let min = Int(ceil((now - self.timeIntervalSince1970) / 60))
            return "\(min) 分钟前"
        } else if calendar.isDateInToday(self) {
            return format(with: "HH:mm")
        } else if calendar.isDateInYesterday(self) {
            return "昨天 \(format(with: "HH:mm"))"
        } else if isSameYear() {
            let month = calendar.component(Calendar.Component.month, from: self)
            let day = calendar.component(Calendar.Component.day, from: self)
            return "\(month) 月 \(day) 日"
        } else {
            let year = calendar.component(Calendar.Component.year, from: self)
            let month = calendar.component(Calendar.Component.month, from: self)
            let day = calendar.component(Calendar.Component.day, from: self)
            return "\(year) 年 \(month) 月 \(day) 日"
        }
    }
    
    public func sameDayAt(year: Int) -> Date {
        var dateComponent = Calendar.current.dateComponents([.year, .month, .day], from: self)
        dateComponent.year = year
        return Calendar.current.date(from: dateComponent).or(self)
    }
    
    public func next(day: Int) -> Date {
        let date = Calendar.current.date(byAdding: .day, value: day, to: self)!
        return date
    }
    
    public func isSameYear(_ compareDate: Date = Date()) -> Bool {
        let calendar = Calendar.current
        let targetYear = Optional(calendar.component(Calendar.Component.year, from: self))
        let compareYear = Optional(calendar.component(Calendar.Component.year, from: compareDate))
        
        return targetYear == compareYear
    }
}


