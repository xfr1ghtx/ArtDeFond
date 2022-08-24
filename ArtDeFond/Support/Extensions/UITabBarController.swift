//
//  UITabBarController.swift
//  ArtDeFond
//
//  Created by developer on 19.08.2022.
//

import Foundation
import UIKit

extension UITabBarController{
    
    static func createDefault(auth: Bool) -> UITabBarController{
        
        let tabBarController = UITabBarController()
        
        let seacrhVC = SearchViewController()
        seacrhVC.tabBarItem.image = Constants.Icons.search
        seacrhVC.tabBarItem.title = "Поиск"
        
        let feedVC = FeedViewController(viewModel: FeedViewModel())
        feedVC.tabBarItem.image = Constants.Icons.house
        feedVC.tabBarItem.title = "Лента"
        
        let uploadPhotoVC = auth ? UploadPhotoViewController(viewModel: .init()) : AuthViewController()
        
        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
                                              image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
                                              tag: 0)
        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
                                                          left: 0,
                                                          bottom: -7,
                                                          right: 0)
        
        let notificationVC = auth ? NotificationsViewController(viewModel: NotificationsViewModel()) : AuthViewController()
        notificationVC.tabBarItem.image = Constants.Icons.bell
        notificationVC.tabBarItem.title = "Уведомления"
                
        let provileVC = auth ? ProfileViewController(viewModel: ProfileViewModel()) : AuthViewController()
        provileVC.tabBarItem.image = Constants.Icons.profile
        provileVC.tabBarItem.title = "Профиль"
        
        let controllers = [feedVC, seacrhVC, uploadPhotoVC, notificationVC, provileVC]
        
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        tabBarController.tabBar.tintColor = Constants.Colors.darkRed
        tabBarController.tabBar.unselectedItemTintColor = Constants.Colors.middleRed
        
        
        tabBarController.tabBar.backgroundColor = .white
        return tabBarController
    }
}
