//
//  UploadPhotoViewModel.swift
//  ArtDeFond
//
//  Created by developer on 24.08.2022.
//

import Foundation
import UIKit

final class UploadPhotoViewModel {
    
    private var model: UploadPhotoModel?
    
    var didGoToNextScreen: ((UIViewController) -> Void)?
    
    init(){
        
    }
    
    func goToNextScreen(image: UIImage, pictureName name: String, pictureDescription desc: String){
        model = .init(pictureImage: image, pictureName: name, pictureDescription: desc)
        
        let vm = PictureDescriptionViewModel()
        vm.delegate = self
        let vc = PictureDescriptionViewController(viewModel: vm)
        didGoToNextScreen?(vc)
    }
}


extension UploadPhotoViewModel: PictureDescriptionViewModelDelegate{
    func getModelFromUploadPhoto() -> UploadPhotoModel? {
        return model
    }
}

