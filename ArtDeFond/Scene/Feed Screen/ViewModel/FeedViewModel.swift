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
    
    private(set) var pictures : [PictureWithAuthorModel] = [] {
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
    
    func loadPictures(completion: @escaping ([PictureWithAuthorModel]) -> Void) {
        PicturesManager.shared.loadPictureInformation(type: .pictures) { [weak self] result in
            guard let self = self else {
                completion([])
                return
            }

            switch result {
            case .failure:
                completion([])
            case .success(let pictures):
                let group = DispatchGroup()
                var models: [String: PictureWithAuthorModel] = [:]
                
                for picture in pictures {
                    group.enter()
                    self.loadUser(for: picture) { user in
                        group.leave()
                        models[picture.id] = PictureWithAuthorModel(user: user, picture: picture)
                    }
                }
            
                group.notify(queue: .main) {
                    let resultModels = pictures.map { models[$0.id] }
                    completion(resultModels.compactMap { $0 })
                }
            }
        }
    }
    
    func loadUser(for picture: Picture, completion: @escaping (User?) -> Void) {
        AuthManager.shared.getUserInformation(for: picture.author_id) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                completion(nil)
            }
        }
    }
    
    func fetchData() {
        refreshing = true
        
        let group = DispatchGroup()
        var outputPictures = [PictureWithAuthorModel]()
        
        group.enter()
        loadPictures { pictures in
            group.leave()
            
            outputPictures = pictures
        }
        
        group.enter()
        var outputAuctions = [CircleFeedAuctionModel]()
        PicturesManager.shared.loadPictureInformation(type: .auctions) { result in
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


