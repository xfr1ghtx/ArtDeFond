//
//  FeedViewModel.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import Foundation


class ProfileViewModel {

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
        PicturesManager.shared.loadPictureInformation(type: .authorsAuctions(id: userId)) { result in
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
}


struct UserPicturesAuctionsModel {
    let pictures: [Picture]
    var auctions: [CircleFeedAuctionModel]? = nil
    var user: User? = nil
}
