//
//  FeedModelViewModel\.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import Foundation

// эта модель содержит поля, которые необходимы для создания картин в firebase, но при этом она берет эти данные для этих полей из слоя View (например: когда пользователь что-то ввел в текст видл и нажал сохранить)

struct Picture: Codable{ // change that
    var id: String
    var title: String
    var image: String
    var description: String
    var year: Int
    var materials: String
    var width: Int
    var height: Int
    var author_id: String
    var price: Int
    var isAuction: Bool
    var auction: Auction?
    var tags: [String]
    var time: Date
}


// вот тут вот хранятся танцы с группами

class ExFeedViewModel: NSObject {
    
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
    
    
//    func fetchData() {
//        refreshing = true
//
//        let group = DispatchGroup()
//        var pictures = [Picture]()
//        group.enter()
//        PicturesManager.shared.loadPictureInformation(type: .pictures) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//
//                group.leave()
//            case .success(let picturesData):
//                pictures = picturesData
//                group.leave()
//            }
//        }
//        group.enter()
//
//        var outputPictures = [FeedPictureModel]()
//
//        pictures.forEach { picture in
//            let pictureGroup = DispatchGroup()
//            pictureGroup.enter()
//
//            var imageView: UIImage?
//            var nickname: String?
//            var authorImageView: UIImage?
//            var authorImageName: String?
//
//            ImageManager.shared.image(with: picture.image) { result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                    pictureGroup.leave()
//                case .success(let imageViewInfo):
//                    print(imageViewInfo)
//                    imageView = imageViewInfo
//                    pictureGroup.leave()
//                }
//            }
//
//            pictureGroup.enter()
//            AuthManager.shared.getUserInformation(for: picture.author_id) { result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                    pictureGroup.leave()
//                case .success(let something):
//                    print(something)
//                    authorImageName = something.avatar_image
//                    nickname = something.nickname
//                    pictureGroup.leave()
//                }
//            }
//            pictureGroup.enter()
//            if let authorImageName = authorImageName {
//                ImageManager.shared.image(with: authorImageName) { result in
//                    switch result {
//                    case .failure(let error):
//                        print(error)
//                        pictureGroup.leave()
//                    case .success(let imageViewInfo):
//                        print(imageViewInfo)
//                        authorImageView = imageViewInfo
//                        pictureGroup.leave()
//                    }
//                }
//            } else {
//                pictureGroup.leave()
//            }
//
//            pictureGroup.notify(queue: .main) {
//                let newPicture = FeedPictureModel(id: picture.id, image: imageView, title: picture.title, authorName: nickname, authorImage: authorImageView)
//                print(newPicture)
//                group.leave()
////                outputPictures.append(newPicture)
//            }
//        }
//        self.pictures = outputPictures
//
//        group.enter()
//        PicturesManager.shared.loadPictureInformation(type: .auctions) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
////                self?.error = error
//                group.leave()
//
//            case .success(let auctions):
//                var outputAuctions = [CircleFeedAuctionModel]()
//                auctions.forEach { auction in
//                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
//                    outputAuctions.append(newAuction)
//                }
//                self?.auctions = outputAuctions
//                group.leave()
//            }
//        }
//
//        group.notify(queue: .main) { [weak self] in
//            print("group one notify")
//            self?.bindFeedViewModelToController()
//            self?.refreshing = false
//        }
//    }
    
    
    
    func fetchData() {
        refreshing = true
        
        let group = DispatchGroup()
        var pictures = [Picture]()
        var outputPictures = [FeedPictureModel]()
        group.enter()
        PicturesManager.shared.loadPictureInformation(type: .pictures) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                
                group.leave()
            case .success(let picturesData):
                pictures = picturesData
                
                pictures.forEach { picture  in
                    let newPicture = FeedPictureModel(id: picture.id, image: nil, title: picture.title, authorName: picture.author_id, authorImage: nil, picture:  picture)
                    outputPictures.append(newPicture)
                }
                self?.pictures = outputPictures
                
                group.leave()
            }
        }
        group.enter()
        
        group.enter()
        PicturesManager.shared.loadPictureInformation(type: .auctions) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
//                self?.error = error
                group.leave()
                
            case .success(let auctions):
                var outputAuctions = [CircleFeedAuctionModel]()
                auctions.forEach { auction in
                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
                    outputAuctions.append(newAuction)
                }
                self?.auctions = outputAuctions
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            print("group one notify")
            self?.bindFeedViewModelToController()
            self?.refreshing = false
        }
    }
    
    
}
