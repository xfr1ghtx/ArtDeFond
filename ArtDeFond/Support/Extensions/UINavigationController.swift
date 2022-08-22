//
//  UINavigationController.swift
//  ArtDeFond
//
//  Created by developer on 14.08.2022.
//

import Foundation
import UIKit

extension UINavigationController{
    
    static func createDefault() -> UINavigationController{
        let navCont = UINavigationController()
        
        navCont.setNavigationBarHidden(true, animated: false)
        
        return navCont
    }
    
    static func createForAuth() -> UINavigationController{
        let navCont = UINavigationController()
        navCont.setNavigationBarHidden(false, animated: false)
        
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        backButton.setBackgroundImage(Constants.Icons.backArrow, for: .normal, barMetrics: .default)
        
        navCont.navigationItem.setLeftBarButton(backButton, animated: false)
        
        return navCont
    }
}
