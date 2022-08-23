//
//  DeliveryModel.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import Foundation


class DelieveryModel {
    var titleInfo: String
    var userInfo: String
    var hasImage: Bool
    
    init(titleInfo: String, userInfo: String, hasImage: Bool) {
        self.titleInfo = titleInfo
        self.userInfo = userInfo
        self.hasImage = hasImage
    }
}

let model: [DelieveryModel] = [
    DelieveryModel(titleInfo: "Адрес", userInfo: "г. Москва, ул. Морозная, д. 105, кв 45", hasImage: false),
    DelieveryModel(titleInfo: "Индекс", userInfo: "100002",  hasImage: false),
    DelieveryModel(titleInfo: "Дата заказа", userInfo: "22.09.09",  hasImage: false),
    DelieveryModel(titleInfo: "Статус", userInfo: "В пути",  hasImage: false),
    DelieveryModel(titleInfo: "Получатель", userInfo: "SOMECOOLNAME",  hasImage: true)
]
