//
//  CostViewModel.swift
//  ArtDeFond
//
//  Created by developer on 24.08.2022.
//

import Foundation

protocol CostViewModelDelegate: AnyObject {
    func getModelFromUploadPhoto() -> UploadPhotoModel?
    func getModelFromPictureDescription() -> PictureDescriptionModel?
}

final class CostViewModel{
    
    private var model: CostModel?
    
    weak var delegate: CostViewModelDelegate?
    
    init(){
        
    }
    
    
    func uploadPicture(cost: String){
        model = .init(cost: cost)
        
        let firstModel = delegate?.getModelFromUploadPhoto()
        let secondModel = delegate?.getModelFromPictureDescription()
        let thirdModel = model
        
        
        let id = UUID().uuidString
        
        
        let width = Int(secondModel?.width ?? "100")
        let height = Int(secondModel?.height ?? "100")
        var price = Int(thirdModel?.cost ?? "100")
        price = (price ?? 100) * 100
        let year = Int(secondModel?.year ?? "2000")
        
        guard
            let pictureTitle  = firstModel?.pictureName,
            let pictureDescription = firstModel?.pictureDescription,
            let pictureImage = firstModel?.pictureImage,
            let tags = secondModel?.tags,
            let materials = secondModel?.materials
                
        else {
            return
        }
        
        var imageNameFromStore = "2.jpeg"
        
        let group = DispatchGroup()
        group.enter()
        ImageManager.shared.upload(image: pictureImage) { result in
            switch result {
            case .failure( _):
                print("error with image")
                group.leave()
            case .success(let imageName):
                group.leave()
                imageNameFromStore = imageName
            }
        }
        
        group.notify(queue: .main) {
            PicturesManager.shared.newPicture(
                id: id,
                title: pictureTitle,
                image: imageNameFromStore,
                description: pictureDescription,
                year: year ?? 2000,
                materials: materials,
                width: width ?? 100,
                height: height ?? 100,
                price: price ?? 100,
                isAuction: false,
                auction: nil,
                tags: tags,
                time: Date.now) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let something):
                        print(something)
                    }
                }
            
            NotificationCenter.default.post(name: NSNotification.Name("CostViewModel.uploadPicture.success.ArtDeFond"), object: nil)
        }
        
    }
}
