//
//  PictureDescriptionViewModel.swift
//  ArtDeFond
//
//  Created by developer on 24.08.2022.
//

import Foundation
import UIKit
import TagListView

protocol PictureDescriptionViewModelDelegate: AnyObject{
    func getModelFromUploadPhoto() -> UploadPhotoModel?
}

final class PictureDescriptionViewModel{
    
    private var model: PictureDescriptionModel?
    
    weak var delegate: PictureDescriptionViewModelDelegate?
    
    var didGoToNextScreen: ((UIViewController) -> Void)?
    
    init(){
        
    }
    
    func goToNextScreen(materials: String, year: String, width: String, height: String, tags: [TagView]){
        model = .init(materials: materials,
                      year: year,
                      width: width,
                      height: height,
                      tags: tags.map{ $0.currentTitle ?? "" })
        
        let vm = CostViewModel()
        vm.delegate = self
        let vc = CostViewController(viewModel: vm)
        
        didGoToNextScreen?(vc)
        
    }
    
}

extension PictureDescriptionViewModel: CostViewModelDelegate{
    func getModelFromUploadPhoto() -> UploadPhotoModel? {
        delegate?.getModelFromUploadPhoto()
    }
    
    func getModelFromPictureDescription() -> PictureDescriptionModel? {
        return model
    }
    
    
}

//viewModel.goTo
//
//let vm = CostViewModel()
//vm.delegate = viewModel
//let vc = CostViewController(viewModel: vm)
//
//navigationController?.pushViewController(vc, animated: true)


