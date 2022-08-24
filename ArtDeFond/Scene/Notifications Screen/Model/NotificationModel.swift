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
            return time.timeToShow()
        }
    }
}
