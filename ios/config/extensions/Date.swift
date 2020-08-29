//
//  Date.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import Foundation

extension Date {
    init(year: Int, month: Int, day: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self = dateFormatter.date(from: "\(year)-\(month)-\(day)") ?? Date.init()
    }
    
    init(detailString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        self = dateFormatter.date(from: detailString) ?? Date.init()
    }
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy. M. d"
        return dateFormatter.string(from: self)
    }
    
    func toDetailString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        return dateFormatter.string(from: self)
    }
}
