//
//  NotificationsViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 22.08.2022.
//

import Foundation
import UIKit

class NotificationsViewModel: NSObject {

    private(set) var notifications : [NotificationAndPictureModel] = [] {
            didSet {
                self.bindFeedViewModelToController()
            }
        }
    
    var bindFeedViewModelToController : (() -> ()) = {}
    
    var refreshing = false
    
    override init() {
            super.init()
            fetchData()
        }

    func loadNotifications(completion: @escaping ([NotificationAndPictureModel]) -> Void) {
        NotificationManager.shared.loadNotifications { [weak self]
            result in
            
            guard let self = self else {
                completion([])
                return
            }
            
            switch result {
            case .failure( _):
                completion([])
            case .success(let notifications):
                let group = DispatchGroup()
                var models: [String: NotificationAndPictureModel] = [:]
                
                for notification in notifications {
                    group.enter()
                    self.loadPicture(for: notification, completion: { picture in
                        group.leave()
                        models[notification.id] = NotificationAndPictureModel(picture: picture, notification: notification)
                    })
                }
                group.notify(queue: .main) {
                    let resultModels = notifications.map { models[$0.id]
                    }
                    completion(resultModels.compactMap { $0 })
                }
            }
        }
    }
    
    func loadPicture(for notification: NotificationModel, completion: @escaping (Picture?) -> Void) {
        PicturesManager.shared.getPictureWithId(with: notification.pictureId) { result in
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let picture):
                completion(picture)
            }
        }
    }
    
    func fetchData() {
        refreshing = true
        
        loadNotifications { notifications in
            self.refreshing = false
            self.notifications = notifications
        }
    }
}


