//
//  PaymentModel.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import Foundation


class PaymentModel {
    var titleInfo: String
    var priceInfo: String
    
    init(titleInfo: String, priceInfo: String) {
        self.titleInfo = titleInfo
        self.priceInfo = priceInfo
    }
}

let payment: [PaymentModel] = [
    PaymentModel(titleInfo: "Картина", priceInfo: "$ 000,00"),
    PaymentModel(titleInfo: "Доставка", priceInfo: "$ 000,00"),
    PaymentModel(titleInfo: "Возможно налог?", priceInfo: "$ 000,00"),
    PaymentModel(titleInfo: "Скидка всем покупателям", priceInfo: "$ 000,00")
]
