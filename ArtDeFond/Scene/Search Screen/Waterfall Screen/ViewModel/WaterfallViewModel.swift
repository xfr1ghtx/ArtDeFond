//
//  WaterfallViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 29.08.2022.
//

import Foundation

class WaterfallViewModel {

    let tagName: String
    
    private(set) var pictures : [Picture] = [] {
            didSet {
                self.bindWaterfallViewModelToController()
            }
        }

    var bindWaterfallViewModelToController : (() -> ()) = {}
    var refreshing = false
    
    
    init(with tagName: String) {
        self.tagName = tagName
        fetchData()
    }
    
    func fetchData(){
        refreshing = true
        
        loadPictures(for: tagName) { pictures in
            self.refreshing = false
            self.pictures = pictures
        }
    }
    
    
    func loadPictures(for tagName: String, completion: @escaping ([Picture]) -> Void){
        PicturesManager.shared.loadPictureInformation(type: .searchTag(text: tagName)) { result in
            switch result {
            case .failure( _):
                completion([])
            case .success(let pictures):
                completion(pictures)
            }
        }
    }
}
