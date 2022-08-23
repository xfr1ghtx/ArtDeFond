//
//  Date.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import Foundation

extension Date {
    
    func isYesterday() -> Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
       
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    static func minutesBetweenDates(_ oldDate: Date, _ newDate: Date) -> Double {
            let newDateMinutes = newDate.timeIntervalSinceReferenceDate/60
            let oldDateMinutes = oldDate.timeIntervalSinceReferenceDate/60

            let result = Double(newDateMinutes - oldDateMinutes)
            return abs(result)
        }

}
