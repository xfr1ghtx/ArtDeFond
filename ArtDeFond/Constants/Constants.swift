//
//  Constants.swift
//  ArtDeFond
//
//  Created by developer on 16.08.2022.
//

import Foundation
import UIKit

class Constants{
    
    class Fonts{
        
        static let regular13 = UIFont.systemFont(ofSize: 13 , weight: .regular)
        static let regular15 = UIFont.systemFont(ofSize: 15 , weight: .regular)
        static let regular17 = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        static let semibold11 = UIFont.systemFont(ofSize: 11, weight: .semibold) //authorFont
        static let semibold17 = UIFont.systemFont(ofSize: 17, weight: .semibold) //authorFont
        static let semibold15 = UIFont.systemFont(ofSize: 15, weight: .semibold) //authorFont
        static let semibold20 = UIFont.systemFont(ofSize: 20, weight: .semibold) //  pictureTitleFont
        
        static let bold24 = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let bold30 = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        static let medium17 = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let medium15 = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    class Colors{
        static let gray = UIColor(named: "Aviator Gray")!
        static let brown = UIColor(named: "Brown River")!
        static let lightRed = UIColor(named: "Light Red Wine")!
        static let darkRed = UIColor(named: "Red Wine")!
        static let middleRed = UIColor(named: "Medium Red Wine")!
        static let pink = UIColor(named: "Smoked Pink")!
        static let white = UIColor(named: "Whitish")!
        static let dirtyWhite = UIColor(named: "Smoked White")!
        static let black = UIColor(named: "Blackish")!
    }
    
    class Icons{
        static let openEye = UIImage(named: "Open Eye")!
        static let closeEye = UIImage(named: "Close Eye")!
        static let bell = UIImage(named: "Bell")!
        static let bigPlus = UIImage(named: "Big plus")!
        static let profile = UIImage(named: "Profile")!
        static let search = UIImage(named: "Search")!
        static let house = UIImage(named: "House")!
        static let backArrow = UIImage(named: "Back arrow")!
        static let avatarPlaceholder = UIImage(named: "avatarPlaceholder")!
    }
    
    class Images{
        static let logo = UIImage(named: "logo")!
    }
    
    class Unspecified{
        static let titleAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.darkRed]
    }
    
}
