//
//  OrderManager.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol OrderManagerDescription {
    
    func loadOrders(type: OrderType, completion: @escaping (Result<[Order], Error>) -> Void)
    
    func newOrder(
        id: String,
        picture_id: String, // picture
        time: Date,
        address_id: String, // address
        status: OrderStatus,
        seller_id: String, // user
        buyer_id: String, // user
        total_amount: Int,
        completion: @escaping (Result<Order, Error>) -> Void
    )
    
    func updateOrderStatus(
        for order_id: String,
        to newStatus: OrderStatus,
        completion: @escaping (Result<Order, Error>) -> Void
    )
    
}


final class OrderManager: OrderManagerDescription {
    private let database = Firestore.firestore()
    static let shared: OrderManagerDescription = OrderManager()
    private init() {}
    
    
    func loadOrders(type: OrderType, completion: @escaping (Result<[Order], Error>) -> Void) {
        var ref: Query = database.collection("orders")
        
        guard let user_id = AuthManager.shared.userID() else {
            return
        }
        
        
        switch type {
        case .common:
            break
        case .purchases:
            ref = ref.whereField("buyer_id", isEqualTo: user_id)
        case .sales:
            ref = ref.whereField("seller_id", isEqualTo: user_id)
        }
        
        ref.getDocuments { [weak self] snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let orders = self?.orders(from: snapshot) {
                completion(.success(orders))
            } else {
                fatalError()
            }
        }
    }
    
    func newOrder(
        id: String = UUID().uuidString,
        picture_id: String,
        time: Date,
        address_id: String,
        status: OrderStatus,
        seller_id: String,
        buyer_id: String,
        total_amount: Int,
        completion: @escaping (Result<Order, Error>) -> Void
    ) {
        let newOrder = Order(id: id, picture_id: picture_id, time: time, address_id: address_id, status: status, seller_id: seller_id, buyer_id: buyer_id, total_amount: total_amount)
        
        try? database.collection("orders").document(id).setData(from: newOrder, encoder: Firestore.Encoder()) { error in

            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(newOrder))
            }
        }
    }
    
    
    func updateOrderStatus(for order_id: String, to newStatus: OrderStatus, completion: @escaping (Result<Order, Error>) -> Void) {
        let rawStatus = newStatus.rawValue
        database.collection("orders").document(order_id).updateData(["status" : rawStatus])
    }
    
    
}

extension OrderManager {
    
    func orders(from snapshot: QuerySnapshot?) -> [Order]? {
        return snapshot?.documents.compactMap { order(from: $0.data()) }
    }
    
    func order(from data: [String: Any]) -> Order? {
        let result = try? Firestore.Decoder().decode(Order.self, from: data)
        return result
    }
    
    func data(from order: Order) -> [String: Any]? {
        do {
            let encoder = Firestore.Encoder()
            let data = try encoder.encode(order)
            return data
        } catch {
            print("Error when trying to encode an order: \(error)")
            return nil
        }
    }
}



struct Order: Codable {
    var id: String
    var picture_id: String // picture
    var time: Date
    var address_id: String // address
    var status: OrderStatus
    var seller_id: String //user
    var buyer_id: String // user
    var total_amount: Int
}


enum OrderStatus: String, Codable {
    case booked
    case purchased
    case sent
    case delivered
}


enum OrderType {
    case common
    case purchases // mine
    case sales // not mine
}
