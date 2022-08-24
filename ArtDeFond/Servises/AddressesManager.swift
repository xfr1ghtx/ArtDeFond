//
//  AdressManager.swift
//  ProjectForFirebase
//
//  Created by The GORDEEVS on 18.08.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


// FIXIT: address to Codable

protocol AddressManagerDescription {
    func loadUsersAddressInformation(
        for user_id: String,
        completion: @escaping (Result<[Address], Error>) -> Void)
    
    func newAddress(
        id: String,
        user_id: String,
        street: String,
        house_number: Int,
        apartment_number: Int,
        post_index: Int,
        district: String,
        city: String,
        completion: @escaping (Result<Address, Error>) -> Void
    )
    
    func updateAddressInformation(
        for id: String,
        with newAddress: Address,
        completion: @escaping (Result<Address, Error>) -> Void)
    
    func deleteAddress(with id: String)
}

final class AddressManager: AddressManagerDescription {
    
    private let database = Firestore.firestore()
    
    static let shared: AddressManagerDescription = AddressManager()
    
    private init() {}
    
    
    func loadUsersAddressInformation(for user_id: String, completion: @escaping (Result<[Address], Error>) -> Void) {
        database.collection("addresses")
            .whereField("user_id", isEqualTo: user_id)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else if let pictures = self?.addresses(from: snapshot) {
                    completion(.success(pictures))
                } else {
                    fatalError()
                }
            }
        
    }
    
    func newAddress(
        id: String = UUID().uuidString,
        user_id: String,
        street: String,
        house_number: Int,
        apartment_number: Int,
        post_index: Int,
        district: String,
        city: String,
        completion: @escaping (Result<Address, Error>) -> Void
    ) {
        let data: [String: Any] = [
            Keys.id.rawValue: id,
            Keys.user_id.rawValue: user_id,
            Keys.street.rawValue: street,
            Keys.house_number.rawValue: house_number,
            Keys.apartment_number.rawValue: apartment_number,
            Keys.post_index.rawValue: post_index,
            Keys.district.rawValue: district,
            Keys.city.rawValue: city
        ]

        database.collection("addresses").document(id).setData(data) { [weak self] error in
            guard let self = self else {
                return
            }

            if let error = error {
                completion(.failure(error))
            } else {
                if let picture = self.address(from: data) {
                    completion(.success(picture))
                } else {
                    fatalError()
                }
            }
        }
        


    }
    
    //FIXIT
    func updateAddressInformation(for id: String, with newAddress: Address, completion: @escaping (Result<Address, Error>) -> Void) {
        self.deleteAddress(with: id)
        
        self.newAddress(
            id: id,
            user_id: newAddress.user_id,
            street: newAddress.street,
            house_number: newAddress.house_number,
            apartment_number: newAddress.apartment_number,
            post_index: newAddress.post_index,
            district: newAddress.district,
            city: newAddress.city,
            completion: { result in
                //
            })
    }
    
    func deleteAddress(with id: String) {
        database.collection("addresses").document(id).delete() { err in
            if let err = err {
                print("Error removing address: \(err)")
            } else {
                print("address successfully removed?")
            }
        }
    }
    
    
    
    
}

extension AddressManager {
    func addresses(from snapshot: QuerySnapshot?) -> [Address]? {
        return snapshot?.documents.compactMap { address(from: $0.data(), with: $0.documentID) }
    }
    
    func address(from data: [String: Any], with id: String = UUID().uuidString) -> Address? {
        guard
            let id = data[Keys.id.rawValue ] as? String,
            let user_id = data[Keys.user_id.rawValue ] as? String,
            let street = data[Keys.street.rawValue ] as? String,
            let house_number = data[Keys.house_number.rawValue ] as? Int,
            let apartment_number = data[Keys.apartment_number.rawValue ] as? Int,
            let post_index = data[Keys.post_index.rawValue ] as? Int,
            let district = data[Keys.district.rawValue ] as? String,
            let city = data[Keys.city.rawValue ] as? String

        else {
            return nil
        }
        
       
        
        return Address(
            id: id,
            user_id: user_id,
            street: street,
            house_number: house_number,
            apartment_number: apartment_number,
            post_index: post_index,
            district: district,
            city: city)
    }
    
    
    enum Keys: String {
        case id
        case user_id
        case street
        case house_number
        case apartment_number
        case post_index
        case district
        case city
    }
}

struct Address: Codable {
    var id: String
    var user_id: String
    var street: String
    var house_number: Int
    var apartment_number: Int
    var post_index: Int
    var district: String
    var city: String
}
