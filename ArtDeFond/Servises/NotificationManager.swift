//
//  NotificationManager.swift
//  ArtDeFond
//
//  Created by Someone on 22.08.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol NotificationManagerDescription {
    func loadNotifications(completion: @escaping (Result<[NotificationModel], Error>) -> Void)
    func newNotification(
        pictureId: String, // picture?
        type: NotificationType,
        orderId: String? ,// order?
        orderStatus: OrderStatus?, // ??
        time: Date,
        completion: @escaping (Result<NotificationModel, Error>) -> Void
    )
    
    
}

final class NotificationManager: NotificationManagerDescription {
    
    private let database = Firestore.firestore()
    
    static let shared: NotificationManagerDescription = NotificationManager()
    
    private init() {}
    
    func loadNotifications(completion: @escaping (Result<[NotificationModel], Error>) -> Void) {
        guard let userId = AuthManager.shared.userID() else {
            return
        }
        
        database.collection("notifications")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else if let notifications = self?.notifications(from: snapshot) {
                    completion(.success(notifications))
                } else {
                    completion(.failure(SomeErrors.somethingWentWrong))
                }
            }
    }
    
    func newNotification(
        pictureId: String, // picture?
        type: NotificationType,
        orderId: String? ,// order?
        orderStatus: OrderStatus?, // ??
        time: Date,
        completion: @escaping (Result<NotificationModel, Error>) -> Void
    ) {
        guard let author_id = AuthManager.shared.userID() else {
            completion(.failure(SomeErrors.somethingWentWrong))
            return
        }
        
        let id = UUID().uuidString
        let newNotification: NotificationModel?
        newNotification = NotificationModel(id: id, userId: author_id, pictureId: pictureId, type: type, orderId: orderId, orderStatus: orderStatus, time: time)
        
        try? database.collection("notifications").document(id).setData(from: newNotification, encoder: Firestore.Encoder()) { error in
            
            if let error = error {
                completion(.failure(error))
            } else {
                if let notification = newNotification {
                    completion(.success(notification))
                } else {
                    fatalError()
                }
            }
        }
    }
}


extension NotificationManager {
    func notifications(from snapshot: QuerySnapshot?) -> [NotificationModel]? {
        return snapshot?.documents.compactMap { notification(from: $0.data()) }
    }
    
    func notification(from data: [String: Any]) -> NotificationModel? {
        let result = try? Firestore.Decoder().decode(NotificationModel.self, from: data)
        return result
    }
    
    func data(from notification: NotificationModel) -> [String: Any]? {
        do {
            let encoder = Firestore.Encoder()
            let data = try encoder.encode(notification)
            return data
        } catch {
            print("Error when trying to encode picture: \(error)")
            return nil
        }
    }
}

//struct Notification: Codable {
//    var id: String?
//    var type: NotificationType
//    var picture_id : String
//    var time: Date?
//}

//enum NotificationType: String, Codable {
//    case yourPictureWasBought
//    case yourPictureWasBetOn
//    case yourAuctionIsEnded
//    
//    case yourBetWasBeaten
//    case youWonAuction
//    case youBoughtPicture
//    
////    Для продавца
////    - Вашу картину купили
////    - На вашу картину поставили ставку
////    - Аукцион на вашу картину завершен
////
////    Для покупателя
////    - Вашу ставку перебили
////    - Вы выиграли аукцион
////    - Вы купили картину
//}


