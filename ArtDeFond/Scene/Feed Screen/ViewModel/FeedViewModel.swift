//
//  FeedViewModel.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import Foundation


class FeedViewModel: NSObject {

    private(set) var auctions : [CircleFeedAuctionModel] = [] {
            didSet {
                self.bindFeedViewModelToController()
            }
        }
    
    private(set) var pictures : [FeedPictureModel] = [] {
            didSet {
                self.bindFeedViewModelToController()
            }
        }
    
    var bindFeedViewModelToController : (() -> ()) = {}
    
    var refreshing = false
    
    override init() {
            super.init()
            fetchData()
        }
    
    func fetchData() {
        refreshing = true
        
        let group = DispatchGroup()
        var outputPictures = [FeedPictureModel]()
        group.enter()
        PicturesManager.shared.loadPictureInformation(type: .pictures) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)

                group.leave()
                
            case .success(let pictures):
                
                pictures.forEach { picture in
                    let newPicture = FeedPictureModel(id: picture.id, image: nil, title: picture.title, authorName: "authorName", authorImage: nil, picture: picture)
                    print(newPicture)
                    outputPictures.append(newPicture)
                }

                group.leave()
            }
        }
        
        group.enter()
        var outputAuctions = [CircleFeedAuctionModel]()
        PicturesManager.shared.loadPictureInformation(type: .auctions) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                group.leave()
                
            case .success(let auctions):
                auctions.forEach { auction in
                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
                    outputAuctions.append(newAuction)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.pictures = outputPictures
            self.auctions = outputAuctions
            self.refreshing = false
        }
    }
    
    
}


