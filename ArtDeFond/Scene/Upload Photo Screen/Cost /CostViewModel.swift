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
        
        
    }
}
