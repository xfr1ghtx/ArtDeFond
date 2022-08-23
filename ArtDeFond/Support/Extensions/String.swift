//
//  String.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import Foundation


extension String {
    func getDateFromIsoString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from:self)
    }
    
    
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
