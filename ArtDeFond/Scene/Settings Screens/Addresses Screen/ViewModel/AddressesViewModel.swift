//
//  AddressesViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation



class AddressesViewModel {
    var addresses: [AddressesModel] = []
    
    var error: Error?
    var refreshing = false
    
    
    func fetchAdresses(completion: @escaping () -> Void) {
        refreshing = true

        guard let userId = AuthManager.shared.userID() else {
            return
        }
        
        AddressManager.shared.loadUsersAddressInformation(for: userId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                completion()
            case .success(let addressesInfo):
                var addresses = [AddressesModel]()
                addressesInfo.forEach { address in
                    let newAddress = AddressesModel(id: address.id, street: address.street, city: address.city, district: address.district, houseNumber: address.house_number, postalCode: address.post_index)
                    
                    addresses.append(newAddress)
                }
                self?.addresses = addresses
                completion()
            }
        }
    }
}



struct AddressesModel {
    let id: String
    let street: String
    let city: String
    let district: String
    let houseNumber: Int
    let postalCode: Int
}
