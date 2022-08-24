//
//  NotificationModel.swift
//  ArtDeFond
//
//  Created by Someone on 24.08.2022.
//

import Foundation


struct NotificationModel: Codable {
    let id: String
    let userId: String
    let pictureId: String
    let type: NotificationType
    let orderId: String?
    let orderStatus: OrderStatus?
    let time: Date
    
    var timeToShow: String? {
        get {
            return timeToShow(from: time)
        }
    }
    
    func timeToShow(from date: Date) -> String? {
        
        if date.isToday() {
            let minsBetween = Date.minutesBetweenDates(date, Date())
            if minsBetween < 60 {
                let minsInt = Int(minsBetween)
                let string = " мин назад"
                return "\(minsInt)" + string
            } else {
                let time = date.dateAndTimetoString(format: "hh:mm a")
                return "сегодня в " + time
            }
        }
        if date.isYesterday(){
            let time = date.dateAndTimetoString(format: "hh:mm a")
            return "вчера в " + time
        }
        return date.dateAndTimetoString(format: "dd MMM' в 'hh:mm a")
    }
}
