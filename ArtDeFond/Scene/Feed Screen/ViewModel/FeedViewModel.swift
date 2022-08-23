//
//  FeedViewModel.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import Foundation


class FeedViewModel {
    var auctions: [CircleFeedAuctionModel] = []
    var pictures: [FeedPictureModel] = []
    
    var error: Error?
    var refreshing = false
    
    
    func fetchData(completion: @escaping () -> Void) {
        refreshing = true
        
        let group = DispatchGroup()
        
        group.enter()
        PicturesManager.shared.loadPictureInformation(type: .pictures) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.error = error
                self?.refreshing = false
                group.leave()
                
            case .success(let pictures):
                var outputPictures = [FeedPictureModel]()
                pictures.forEach { picture in
                    let newPicture = FeedPictureModel(id: picture.id, image: picture.image, title: picture.title, authorName: "authorName", authorImage: "authorImage")
                    outputPictures.append(newPicture)
                }
                self?.pictures = outputPictures
                self?.refreshing = false
                group.leave()
            }
        }
        
        group.enter()
        PicturesManager.shared.loadPictureInformation(type: .auctions) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.error = error
                self?.refreshing = false
                group.leave()
                
            case .success(let auctions):
                var outputAuctions = [CircleFeedAuctionModel]()
                auctions.forEach { auction in
                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
                    outputAuctions.append(newAuction)
                }
                self?.auctions = outputAuctions
                self?.refreshing = false
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func fetchAuctions(completion: @escaping () -> Void) {
        refreshing = true
        
        PicturesManager.shared.loadPictureInformation(type: .auctions) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.error = error
                self?.refreshing = false
                completion() // а надо ли?
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
    
    
}


