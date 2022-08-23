//
//  NotificationsViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 22.08.2022.
//

import Foundation
import UIKit

class NotificationsViewModel {
    var notifications: [NotificationModel] = []
    
    var error: Error?
    var refreshing = false
    
    
//    func fetchNotifications(completion: @escaping () -> Void) {
//        refreshing = true
//        let group = DispatchGroup()
//
//        var dataArray = [NotificationWholeModel]()
//        var notifications = [NotificationModel]()
//
//
//        group.enter()
//
//        NotificationManager.shared.loadNotifications{ result in
//            switch result {
//            case .failure(let error):
//                print(error)
//                group.leave()
//
//            case .success(let originalNotifications):
//                notifications = originalNotifications
//                print(notifications)
//            }
//        }
//
//        notifications.forEach { item in
//            PicturesManager.shared.getPictureWithId(with: item.pictureId) { result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                    group.leave()
//                case .success(let picture):
//                    print(picture)
//
//                    dataArray.append(NotificationWholeModel(notificationModel: item, pictureTitle: picture.title, pictureImageName: picture.image))
//                    group.leave()
//                }
//            }
//        }
//
//
//        group.notify(queue: .main) {
//            completion()
//            }
//    }
    
    
    func fetchNotifications(completion: @escaping () -> Void) {
        refreshing = true

        NotificationManager.shared.loadNotifications{ result in
            switch result {
            case .failure(let error):
                print(error)
                completion()

            case .success(let something):
                self.notifications = something
                completion()
            }
        }

    }
    
    
}
