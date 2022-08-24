//
//  NotificationType.swift
//  ArtDeFond
//
//  Created by Someone on 24.08.2022.
//

import Foundation


enum NotificationType: String, Codable {
    case yourPictureWasBought
    case yourPictureWasBetOn
    case yourAuctionWasEnded
    
    case yourBetWasBeaten
    case youWonAuction
    case youBoughtPicture
}
