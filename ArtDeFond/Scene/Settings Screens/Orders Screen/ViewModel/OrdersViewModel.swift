//
//  OrdersViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation

class OrdersViewModel {
    
    let type: OrderType
    var refreshing = false
    
    private(set) var orders: [OrderAndPictureModel] = [] {
            didSet {
                self.bindOrdersViewModelToController()
            }
        }
    
    var bindOrdersViewModelToController : (() -> ()) = {}
    
    required init(for type: OrderType) {
        self.type = type
            fetchData()
        }
    
    
    func fetchData(){
        refreshing = true
        
        loadOrders { orders in
            self.refreshing = false
            self.orders = orders
        }
    }
    
    
    func loadOrders(completion: @escaping ([OrderAndPictureModel]) -> Void) {
        
        OrderManager.shared.loadOrders(type: type) { [weak self] result in
            
            guard let self = self else {
                completion([])
                return
            }
            
            switch result {
            case .failure( _):
                completion([])
            case .success(let orders):
                let group = DispatchGroup()
                var models: [String: OrderAndPictureModel] = [:]
                
                for order in orders {
                    group.enter()
                    self.loadPicture(for: order) { picture in
                        group.leave()
                        models[order.id] = OrderAndPictureModel(order: order, picture: picture)
                    }
                }
                group.notify(queue: .main) {
                    let resultModels = orders.map {
                        models[$0.id]
                    }
                    completion(resultModels.compactMap { $0 })
                }
            }
        }
        
    }
    
    func loadPicture(for order: Order, completion: @escaping (Picture?) -> Void) {
        PicturesManager.shared.getPictureWithId(with: order.picture_id) { result in
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let picture):
                completion(picture)
            }
        }
    }
}
