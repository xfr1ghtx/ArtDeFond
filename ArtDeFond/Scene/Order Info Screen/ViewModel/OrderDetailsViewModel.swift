//
//  OrderDetailsViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 24.08.2022.
//

import Foundation

class OrderDetailViewModel {
    
    var orderId: String

    private(set) var order: OrderWithUsersModel? {
        didSet {
            self.bindOrderDetailViewModelToController()
        }
    }
    
    var bindOrderDetailViewModelToController : (() -> ()) = {}
 
    var refreshing = false
    
    required init(with orderId: String){
        self.orderId = orderId
        fetchData()
    }
    
    
    
    
    func loadOrder(completion: @escaping (OrderWithUsersModel?) -> Void) {
        OrderManager.shared.getOrderWithId(with: orderId) { [weak self] result in
            guard let self = self else {
                completion(nil)
                return
            }
            
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let orderData):
                
                var order = OrderWithUsersModel(order: orderData)
                
                let group = DispatchGroup()
                
                group.enter()
                self.loadPicture(for: orderData) { picture in
                    group.leave()
                    order.picture = picture
                    
                }
                group.enter()
                self.loadUser(with: orderData.buyer_id) { user in
                    group.leave()
                    order.buyerUser = user
                }
                
                group.enter()
                self.loadUser(with: orderData.seller_id) { user in
                    group.leave()
                    order.sellerUser = user
                }
                
                group.enter()
                self.loadAddress(for: orderData) { address in
                    group.leave()
                    order.address = address
                }
                
                group.notify(queue: .main) {
                    print(#function)
                    self.refreshing = false
                    completion(order)
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
    
    func loadAddress(for order: Order, completion: @escaping (Address?) -> Void) {
        AddressManager.shared.getAddressWithId(with: order.address_id) { result  in
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let address):
                completion(address)
            }
        }
    }
    
    func loadUser(with userId: String, completion: @escaping (User?) -> Void) {
        AuthManager.shared.getUserInformation(for: userId) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure( _):
                completion(nil)
            }
        }
    }
    
    func fetchData() {
        refreshing = true
        
        loadOrder { order in
            self.refreshing = false
            self.order = order
        }
    }
}

struct OrderWithUsersModel {
    let order: Order
    var buyerUser: User? = nil
    var sellerUser: User? = nil
    var picture: Picture? = nil
    var address: Address? = nil
}
