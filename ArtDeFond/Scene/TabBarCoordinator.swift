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
    
    private let isAuth: Bool
    
    init(rootViewController: UINavigationController){
        self.rootViewController = rootViewController
        childCoordinators = []
        
        isAuth = AuthManager.shared.isAuthed()
        observeNotificationCenter()
    }
    
    private func observeNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(setLoginViewControllers), name: NSNotification.Name("InterestViewController.signUp.succes.ArtDeFond"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToFeedTab), name: NSNotification.Name("CostViewModel.uploadPicture.success.ArtDeFond"), object: nil)
    }
    
    private func setup(isAuth: Bool) {
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        rootTabBarController = UITabBarController()
        let firstTab = setupFirstTab()
        let secondTab = setupSecondTab()
        let thirdTab = setupThirdTab()
        let fouthTab = setupFouthTab()
        let fifthTab = setupFifthTab()
        var controllers = [firstTab, secondTab, thirdTab, fouthTab, fifthTab]
        controllers = controllers.map { UINavigationController(rootViewController: $0)}
        rootTabBarController.tabBar.tintColor = Constants.Colors.darkRed
        rootTabBarController.tabBar.unselectedItemTintColor = Constants.Colors.middleRed
        rootTabBarController.tabBar.backgroundColor = .white
    }
    
    private func setupFirstTab() -> UIViewController{
        let seacrhVC = SearchViewController()
        seacrhVC.tabBarItem.image = Constants.Icons.search
        seacrhVC.tabBarItem.title = "Поиск"
        return seacrhVC
    }
    
    private func setupSecondTab() -> UIViewController{
        let feedVC = FeedViewController(viewModel: FeedViewModel())
        feedVC.tabBarItem.image = Constants.Icons.house
        feedVC.tabBarItem.title = "Лента"
        return feedVC
    }
    
    private func setupThirdTab() -> UIViewController{
        let uploadPhotoVC = isAuth ? UploadPhotoViewController(viewModel: .init()) : AuthViewController()
        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
                                                image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
                                                tag: 0)
        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
                                                            left: 0,
                                                            bottom: -7,
                                                            right: 0)
        return uploadPhotoVC
    }
    
    private func setupFouthTab() -> UIViewController{
        let notificationVC = isAuth ? NotificationsViewController(viewModel: NotificationsViewModel()) : AuthViewController()
        notificationVC.tabBarItem.image = Constants.Icons.bell
        notificationVC.tabBarItem.title = "Уведомления"
        return notificationVC
    }
    
    private func setupFifthTab() -> UIViewController{
        let provileVC = isAuth ? ProfileViewController(viewModel: ProfileViewModel()) : AuthViewController
        provileVC.tabBarItem.image = Constants.Icons.profile
        provileVC.tabBarItem.title = "Профиль"
        return provileVC
    }
    
    func start() {
        rootViewController.pushViewController(rootTabBarController, animated: true)
    }
    
    @objc
      func goToFeedTab(){
          rootTabBarController.selectedIndex = 0
      }
    
    
    @objc
    func setLoginViewControllers(){
        let seacrhVC = SearchViewController()
        seacrhVC.tabBarItem.image = Constants.Icons.search
        seacrhVC.tabBarItem.title = "Поиск"
        
        let feedVC = FeedViewController(viewModel: FeedViewModel())
        feedVC.tabBarItem.image = Constants.Icons.house
        feedVC.tabBarItem.title = "Лента"
        
        let uploadPhotoVC = UploadPhotoViewController(viewModel: .init())
        
        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
                                                image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
                                                tag: 0)
        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
                                                            left: 0,
                                                            bottom: -7,
                                                            right: 0)
        
        let notificationVC = NotificationsViewController(viewModel: NotificationsViewModel())
        notificationVC.tabBarItem.image = Constants.Icons.bell
        notificationVC.tabBarItem.title = "Уведомления"
        
        let provileVC = ProfileViewController(viewModel: ProfileViewModel())
        provileVC.tabBarItem.image = Constants.Icons.profile
        provileVC.tabBarItem.title = "Профиль"
        
        let controllers = [feedVC, seacrhVC, uploadPhotoVC, notificationVC, provileVC]
        
        rootTabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
    }
}

extension TabBarCoordinator: AuthViewContollerDelegate{
    func DidLogin() {
        let seacrhVC = SearchViewController()
        seacrhVC.tabBarItem.image = Constants.Icons.search
        seacrhVC.tabBarItem.title = "Поиск"
        
        let feedVC = FeedViewController(viewModel: FeedViewModel())
        feedVC.tabBarItem.image = Constants.Icons.house
        feedVC.tabBarItem.title = "Лента"
        
        let uploadPhotoVC = UploadPhotoViewController(viewModel: .init())
        
        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
                                              image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
                                              tag: 0)
        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
                                                          left: 0,
                                                          bottom: -7,
                                                          right: 0)
        
        let notificationVC = NotificationsViewController(viewModel: NotificationsViewModel())
        notificationVC.tabBarItem.image = Constants.Icons.bell
        notificationVC.tabBarItem.title = "Уведомления"
        
        let provileVC = ProfileViewController(viewModel: ProfileViewModel())
        provileVC.tabBarItem.image = Constants.Icons.profile
        provileVC.tabBarItem.title = "Профиль"
        
        let controllers = [feedVC, seacrhVC, uploadPhotoVC, notificationVC, provileVC]
        
        rootTabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
    }
    
    
}
