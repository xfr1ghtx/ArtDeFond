//
//  FeedViewModel.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import Foundation


class ProfileViewModel {
//    var auctions: [CircleFeedAuctionModel] = []
//    var pictures: [ProfilePictureModel] = []
//    var user: ProfileUserModel? = nil
    let userId = AuthManager.shared.userID()
    

    
    private(set) var auctions : [CircleFeedAuctionModel] = [] {
            didSet {
                self.bindProfileViewModelToController()
            }
        }
    
    private(set) var pictures : [Picture] = [] {
            didSet {
                self.bindProfileViewModelToController()
            }
        }
    private(set) var user : User? {
            didSet {
                self.bindProfileViewModelToController()
            }
        }
    
//    private(set) var model : UserPicturesAuctionsModel? {
//            didSet {
//                self.bindProfileViewModelToController()
//            }
//        }
    var bindProfileViewModelToController : (() -> ()) = {}
    
    var refreshing = false
    
    
    
    init() {
        fetchData()
    }
    
    func fetchData(){
        refreshing = true
        
        let group = DispatchGroup()
        
        var outputPictures: [Picture] = []
        var outputAuctions: [CircleFeedAuctionModel] = []
        var outputUser: User? = nil
        
        guard let userId = userId else {
            return
        }
        
        group.enter()
        loadPictures(for: userId) { pictures in
            outputPictures = pictures
            group.leave()
        }
        group.enter()
        loadUser(for: userId) { user in
            outputUser = user
            group.leave()
        }
        group.enter()
        loadAuctions(for: userId) { auctions in
            outputAuctions = auctions
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.refreshing = false
            self.user = outputUser
            self.pictures = outputPictures
            self.auctions = outputAuctions
            
        }
        

    }
    
    
    func loadPictures(for userId: String, completion: @escaping ([Picture]) -> Void){
        PicturesManager.shared.loadPictureInformation(type: .authorsPictures(id: userId)) { result in
            switch result {
            case .failure( _):
                completion([])
            case .success(let pictures):
                completion(pictures)
            }
        }
    }
    
    func loadAuctions(for userId: String, completion: @escaping ([CircleFeedAuctionModel]) -> Void){
        PicturesManager.shared.loadPictureInformation(type: .authorsPictures(id: userId)) { result in
            switch result {
            case .failure( _):
                completion([])
            case .success(let auctions):
                var outputAuctions = [CircleFeedAuctionModel]()
                auctions.forEach { auction in
                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
                    outputAuctions.append(newAuction)
                }
                completion(outputAuctions)
            }
        }
    }
    
    func loadUser(for userId: String, completion: @escaping (User?) -> Void){
        AuthManager.shared.getUserInformation(for: userId) { result in
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let user):
                completion(user)
            }
        }
    }
    
    
    
    
    
    
//    func fetchPictures(completion: @escaping () -> Void) {
//        refreshing = true
//
//
//        guard let userId = AuthManager.shared.userID() else {
//            self.error = NetworkError.two
//            return
//        }
//
//
//        PicturesManager.shared.loadPictureInformation(type: .authorsPictures(id: userId)) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//                self?.error = error
//                self?.refreshing = false
//                completion()
//            case .success(let pictures):
//                var outputPictures = [ProfilePictureModel]()
//                pictures.forEach { picture in
//
//                    let newPicture = ProfilePictureModel(id: picture.id, title: picture.title, price: picture.price, year: picture.year, widht: picture.width, height: picture.height, description: picture.description, image: picture.image)
//                    outputPictures.append(newPicture)
//                }
//                self?.pictures = outputPictures
//                self?.refreshing = false
//                completion()
//            }
//        }
//    }
    
//    func fetchAuctions(completion: @escaping () -> Void) {
//        refreshing = true
//
//        guard let userId = AuthManager.shared.userID() else {
//            self.error = NetworkError.three
//            return
//        }
//
//        PicturesManager.shared.loadPictureInformation(type: .authorsAuctions(id: userId)) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//                self?.error = error
//                self?.refreshing = false
//                completion()
//            case .success(let auctions):
//                var outputAuctions = [CircleFeedAuctionModel]()
//                auctions.forEach { auction in
//                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
//                    outputAuctions.append(newAuction)
//                }
//                self?.auctions = outputAuctions
//                self?.refreshing = false
//                completion()
//            }
//        }
//    }
//
//
//    func fetchUser(completion: @escaping () -> Void) {
//        refreshing = true
//
//
//        guard let userId = AuthManager.shared.userID() else {
//            self.error = NetworkError.four
//            return
//        }
//
//        AuthManager.shared.getUserInformation(for: userId) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                self?.error = error
//                self?.refreshing = false
//                completion()
//            case .success(let userInfo):
//                let userOutput = ProfileUserModel(id: userInfo.id, nickname: userInfo.nickname, description: userInfo.description, userImage: userInfo.avatar_image, accountBalance: userInfo.account_balance)
//                self?.user = userOutput
//                self?.refreshing = false
//                completion()
//            }
//        }
//
//
//    }
}


struct UserPicturesAuctionsModel {
    let pictures: [Picture]
    var auctions: [CircleFeedAuctionModel]? = nil
    var user: User? = nil
}
