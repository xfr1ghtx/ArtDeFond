//
//  TabBarCoordinator.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import Foundation
import UIKit
import FirebaseAuth

final class TabBarCoordinator: Coordinator{
    var rootViewController: UINavigationController
    
    var rootTabBarController: UITabBarController
    
    var childCoordinators: [Coordinator]
    
    init(rootViewController: UINavigationController){
        self.rootViewController = rootViewController
        childCoordinators = []
        
        let isAuthed = AuthManager.shared.isAuthed()
        
        rootTabBarController = UITabBarController.createDefault(auth: true)
    }
    
    func start() {
        rootViewController.pushViewController(rootTabBarController, animated: true)
    }

}
