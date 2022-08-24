//
//  Int.swift
//  ArtDeFond
//
//  Created by Someone on 24.08.2022.
//

import Foundation

extension Int {
    func toRubles() -> String {
        let stringDouble = String(format: "%.2f", Double(self)/100)
        return "\(self/100)₽"
    }
}
