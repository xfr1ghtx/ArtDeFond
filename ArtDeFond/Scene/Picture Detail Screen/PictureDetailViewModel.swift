//
//  PictureDetailViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 22.08.2022.
//

import Foundation


class PictureDetailViewModel {
    
    var pictureId: String

    private(set) var picture: FeedPictureModel? {
        didSet {
            self.bindFeedViewModelToController()
        }
    }
    
    var bindFeedViewModelToController : (() -> ()) = {}
 
    var refreshing = false
    
    required init(with pictureId: String){
        self.pictureId = pictureId
        fetchData()
    }
    
    func loadPicture(completion: @escaping (FeedPictureModel?) -> Void) {
        
        
        PicturesManager.shared.getPictureWithId(with: pictureId) { [weak self] result in
            guard let self = self else {
                completion(nil)
                return
            }
            
            switch result {
            case .failure(let error):
                completion(nil)
            case .success(let picture):
                
                self.loadUser(for: picture) { user in
                    let resultModel = FeedPictureModel(user: user, picture: picture)
                    completion(resultModel)
                }
            }
        }
        
        
        
        //    PicturesManager.shared.loadPictureInformation(type: .pictures) { [weak self] result in
        //        guard let self = self else {
        //            completion(nil)
        //            return
        //        }
        //
        //        switch result {
        //        case .failure:
        //            completion([])
        //        case .success(let pictures):
        //            let group = DispatchGroup()
        //            var models: [String: FeedPictureModel] = [:]
        //
        //            for picture in pictures {
        //                group.enter()
        //                self.loadUser(for: picture) { user in
        //                    group.leave()
        //                    models[picture.id] = FeedPictureModel(user: user, picture: picture)
        //                }
        //            }
        //
        //            group.notify(queue: .main) {
        //                let resultModels = pictures.map { models[$0.id] }
        //                completion(resultModels.compactMap { $0 })
        //            }
        //        }
        //    }
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
        
        loadPicture { pictureModel in
            self.refreshing = false
            self.picture = pictureModel
            
        }
    }
}

