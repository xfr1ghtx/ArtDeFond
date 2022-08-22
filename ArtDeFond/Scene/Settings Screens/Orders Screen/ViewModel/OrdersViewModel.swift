//
//  OrdersViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation

class OrdersViewModel {
    
    var orders: [OrderModel] = []
    var error: Error?
    var refreshing = false
    
    func fetchOrders(type: OrderType, completion: @escaping () -> Void) {
        refreshing = true

        OrderManager.shared.loadOrders(type: type) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.error = error
                self?.refreshing = false
                completion()
            case .success(let orders):
                var ordersOutput = [OrderModel]()
                orders.forEach { order in
                    let newOrder = OrderModel(id: order.id, picture_image: order.picture_id, status: order.status, picture_name: order.picture_id, time: order.time)
                    ordersOutput.append(newOrder)
                }
                self?.orders = ordersOutput
                self?.refreshing = false
                completion()
            }
        }
    }
}
