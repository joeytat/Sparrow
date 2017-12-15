//
//  String+Extension.swift
//  Alamofire
//
//  Created by Joey on 27/11/2017.
//

import Foundation

public extension String {
    public func date(with format: String = "yyyy-MM-dd hh:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

public extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isEmpty
        }
    }
    
    public var isNotNilNotEmpty: Bool {
        return !isNilOrEmpty
    }
}


public extension String {
    public func widthWithConstrainedWidth(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: font.lineHeight)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.width
    }
    
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
}

// MARK: - Validation
public extension String {
    public func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    public func isPhoneNumber(strict: Bool = false) -> Bool {
        // TODO: - 补全严格校验
        let match = matches(for: "^(13[0-9]|14[579]|15[0-3,5-9]|17[0135678]|18[0-9])\\d{0,8}$")
        return match.count > 0
    }
    
    public func isIdCard() -> Bool {
        return self.matches(for: "^([1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X))$").count > 0
    }
}
