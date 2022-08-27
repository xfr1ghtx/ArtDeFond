//
//  PictureDetailViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 22.08.2022.
//

import Foundation


class PictureDetailViewModel {
    
    var pictureId: String

    private(set) var picture: PictureWithAuthorModel? {
        didSet {
            self.bindFeedViewModelToController()
        }
    }
    
    var bindFeedViewModelToController : (() -> ()) = {}
 
    var refreshing = false
    
    var didUpdate: (() -> Void)?
    
    required init(with pictureId: String){
        self.pictureId = pictureId
        fetchData()
    }
    
    func loadPicture(completion: @escaping (PictureWithAuthorModel?) -> Void) {
        
        
        PicturesManager.shared.getPictureWithId(with: pictureId) { [weak self] result in
            guard let self = self else {
                completion(nil)
                return
            }
            
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let picture):
                
                self.loadUser(for: picture) { user in
                    let resultModel = PictureWithAuthorModel(user: user, picture: picture)
                    completion(resultModel)
                }
            }
        }
    }
    
    func loadUser(for picture: Picture, completion: @escaping (User?) -> Void) {
        AuthManager.shared.getUserInformation(for: picture.author_id) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure( _):
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

