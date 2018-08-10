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
        let day: TimeInterval = 60 * 60 * 24
        let hourStr = self.format(with: "HH:mm")
        
        let target = self.startOfTheDay.timeIntervalSince1970
        
        if now - target > (day * 7) {
            return format(with: "yyyy/MM/dd")
        } else if now - target > (day * 2) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.weekday], from: self)
            let format = NumberFormatter()
            format.numberStyle = NumberFormatter.Style.spellOut
            let weekday = format.string(from: NSNumber.init(value: components.weekday.or(0))).orEmpty
            return "星期\(weekday) \(hourStr)"
        } else if now - target > day {
            return "昨天 \(hourStr)"
        } else if !displayJustNow || now - self.timeIntervalSince1970 > 120 { // 两分钟
            return hourStr
        } else {
            return "刚刚"
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
    
}


