//
//  FeedViewModel.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import Foundation


class ProfileViewModel {
    var auctions: [CircleFeedAuctionModel] = []
    var pictures: [ProfilePictureModel] = []
    var user: ProfileUserModel? = nil
    
    var error: Error?
    var refreshing = false
    
    func fetchPictures(completion: @escaping () -> Void) {
        refreshing = true

        
        guard let userId = AuthManager.shared.userID() else {
            self.error = NetworkError.two
            return
        }
        
        
        PicturesManager.shared.loadPictureInformation(type: .authorsPictures(id: userId)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.error = error
                self?.refreshing = false
                completion()
            case .success(let pictures):
                var outputPictures = [ProfilePictureModel]()
                pictures.forEach { picture in
                    
                    let newPicture = ProfilePictureModel(id: picture.id, title: picture.title, price: picture.price, year: picture.year, widht: picture.width, height: picture.height, description: picture.description, image: picture.image)
                    outputPictures.append(newPicture)
                }
                self?.pictures = outputPictures
                self?.refreshing = false
                completion()
            }
        }
    }
    
    func fetchAuctions(completion: @escaping () -> Void) {
        refreshing = true
        
        guard let userId = AuthManager.shared.userID() else {
            self.error = NetworkError.three
            return
        }
        
        PicturesManager.shared.loadPictureInformation(type: .authorsAuctions(id: userId)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.error = error
                self?.refreshing = false
                completion()
            case .success(let auctions):
                var outputAuctions = [CircleFeedAuctionModel]()
                auctions.forEach { auction in
                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
                    outputAuctions.append(newAuction)
                }
                self?.auctions = outputAuctions
                self?.refreshing = false
                completion()
            }
        }
    }
    
    
    func fetchUser(completion: @escaping () -> Void) {
        refreshing = true
        
        
        guard let userId = AuthManager.shared.userID() else {
            self.error = NetworkError.four
            return
        }
        
        AuthManager.shared.getUserInformation(for: userId) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
                self?.refreshing = false
                completion()
            case .success(let userInfo):
                let userOutput = ProfileUserModel(id: userInfo.id, nickname: userInfo.nickname, description: userInfo.description, userImage: userInfo.avatar_image, accountBalance: userInfo.account_balance)
                self?.user = userOutput
                self?.refreshing = false
                completion()
            }
        }
        
        
    }
}
