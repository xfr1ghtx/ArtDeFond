//
//  PictureManager.swift
//  ArtDeFond
//
//  Created by Someone on 20.08.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol PicturesManagerDescription {
    
    func loadPictureInformation(type: ProductCollectionType, completion: @escaping (Result<[Picture], Error>) -> Void)
    // types
    //      pictures by seller_id
    //      auctions by seller_id
    //      auctions
    //      common pictures
    //      search(string)
    
    // sorted by date
    // add date field
    
    
    func newPicture(
        id: String,
        title: String,
        image: String,
        description: String,
        year: Int,
        materials: String,
        width: Int,
        height: Int,
        price: Int,
        isAuction: Bool,
        auction: Auction?,
        tags: [String],
        time: Date,
        completion: @escaping (Result<Picture, Error>) -> Void
    )
    
    func updatePictureInformation(for id: String, with newPicture: Picture, completion: @escaping (Result<Picture, Error>) -> Void)
    
    func deletePicture(with id: String)
    
    func getPictureWithId(with id: String, completion: @escaping (Result<Picture, Error>) -> Void)
}


final class PicturesManager: PicturesManagerDescription {
    //    func newAuction(id: String, title: String, image: String, description: String, year: Int, materials: String, width: Int, height: Int, price: Int, isAuction: Bool,
    //                    auction: Auction, tags: [String], time: Date, completion: @escaping (Result<Picture, Error>) -> Void) {
    //        //
    //    }
    
    
    private let database = Firestore.firestore()
    
    static let shared: PicturesManagerDescription = PicturesManager()
    
    private init() {}
    
    func loadPictureInformation(type: ProductCollectionType, completion: @escaping (Result<[Picture], Error>) -> Void) {
        
        var ref: Query = database.collection("pictures")
        
        switch type {
        case .pictures:
            ref = ref
                .whereField("isAuction", isEqualTo: false)
            
        case .auctions:
            ref = ref
                .whereField("isAuction", isEqualTo: true)
        case .authorsAuctions(let id):
            ref = ref
                .whereField("isAuction", isEqualTo: true)
                .whereField("author_id", isEqualTo: id)
        case .authorsPictures(let id):
            ref = ref
                .whereField("isAuction", isEqualTo: false)
                .whereField("author_id", isEqualTo: id)
        case .search(let text):
            ref = ref
                .whereField("title", isGreaterThanOrEqualTo: "\(text)")
                .whereField("title", isLessThanOrEqualTo: "\(text)\u{f8ff}")
            // FIXIT:  не работает если вхождение не в начале строки
            
        case .searchTag(let tagName):
            ref = ref
                .whereField("tags", arrayContains: tagName)
        }
        
        ref.getDocuments { [weak self] snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let pictures = self?.pictures(from: snapshot) {
                completion(.success(pictures))
            } else {
                fatalError()
            }
        }
    }
    
    
    func newPicture(
        id: String = UUID().uuidString,
        title: String,
        image: String,
        description: String,
        year: Int,
        materials: String,
        width: Int,
        height: Int,
        price: Int,
        isAuction: Bool,
        auction: Auction?,
        tags: [String],
        time: Date,
        completion: @escaping (Result<Picture, Error>) -> Void
    ) {
//        guard let author_id = AuthManager.shared.userID() else {
//            completion(.failure(SomeErrors.somethingWentWrong))
//            return
//        }
        let author_id = "1234" // mock
        
        let newPicture: Picture?
        newPicture = Picture(id: id, title: title, image: image , description: description, year: year, materials: materials, width: width, height: height, author_id: author_id, price: price, isAuction: isAuction, auction: auction, tags: tags, time: Date.distantFuture)
        
        try? database.collection("pictures").document(id).setData(from: newPicture, encoder: Firestore.Encoder()) { error in
            
            if let error = error {
                completion(.failure(error))
            } else {
                if let picture = newPicture {
                    completion(.success(picture))
                } else {
                    fatalError()
                }
            }
        }
    }
    
    
    func deletePicture(with id: String) {
        database.collection("pictures").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Picture successfully removed!")
            }
        }
    }
    
    
    func getPictureWithId(with id: String, completion: @escaping (Result<Picture, Error>) -> Void) {
        database.collection("pictures").document(id).getDocument { (document, err) in
            if let err = err {
                completion(.failure(err))
            } else {
                guard let document = document,
                      document.exists,
                      let data = document.data(),
                      let picture = self.picture(from: data)
                else {
                    return
                }
                completion(.success(picture))
            }
        }
    }
    
    func updatePictureInformation(for id: String, with newPicture: Picture, completion: @escaping (Result<Picture, Error>) -> Void) {
        
        self.deletePicture(with: id)
        
        try? database.collection("pictures").document(id)
            .setData(from: newPicture, encoder: Firestore.Encoder()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(newPicture))
                }
            }
    }
}



private extension PicturesManager {
    
    func pictures(from snapshot: QuerySnapshot?) -> [Picture]? {
        return snapshot?.documents.compactMap { picture(from: $0.data()) }
    }
    
    func picture(from data: [String: Any]) -> Picture? {
        let result = try? Firestore.Decoder().decode(Picture.self, from: data)
        return result
    }
    
    func data(from picture: Picture) -> [String: Any]? {
        do {
            let encoder = Firestore.Encoder()
            let data = try encoder.encode(picture)
            return data
        } catch {
            print("Error when trying to encode picture: \(error)")
            return nil
        }
    }
    
}


struct Picture: Codable {
    var id: String
    var title: String
    var image: String
    var description: String
    var year: Int
    var materials: String
    var width: Int
    var height: Int
    var author_id: String
    var price: Int
    var isAuction: Bool
    var auction: Auction?
    var tags: [String]
    var time: Date
    
}


enum ProductCollectionType {
    case pictures
    case auctions
    case authorsPictures(id: String)
    case authorsAuctions(id: String)
    case search(text: String)
    case searchTag(text: String)
}



enum SomeErrors: Error {
    case somethingWentWrong
}



struct Auction: Codable{
    var id: String
    var picture_id: String
    var originalPrice: Int
    var startAuctionDate: Date?
    var endAuctionDate: Date?
    var minAuctionStep: Int
}
