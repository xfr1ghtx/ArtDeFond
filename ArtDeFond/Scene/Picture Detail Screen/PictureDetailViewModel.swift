//
//  PictureDetailViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 22.08.2022.
//

import Foundation


class PictureDetailViewModel {
    
    var pictureId: String
    var picture: Picture? = nil
    
    var error: Error?
    var refreshing = false
    
    var didUpdate: (() -> Void)?
    
    required init(with pictureId: String){
        self.pictureId = pictureId
    }
    
    func getData(){
        //тут что-то происходит
        
        self.didUpdate?()
    }

    func fetchPicture(completion: @escaping () -> Void) {
        refreshing = true
        
//        guard
//            let pictureId = pictureId
//        else {
//            self.error = NetworkError.shitHappens
//            return
//        }
        
        
        PicturesManager.shared.getPictureWithId(with: pictureId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.error = error
                self?.refreshing = false
                completion()
            case .success(let something):
                self?.refreshing = false
                self?.picture = something
                completion()
            }
        }
    }
}
