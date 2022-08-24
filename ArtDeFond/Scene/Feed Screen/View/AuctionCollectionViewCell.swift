//
//  File.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import Foundation
import UIKit
import SnapKit


class AuctionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AuctionCollectionViewCell"
    var auctionModel: CircleFeedAuctionModel?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 64.0 / 2.0
        imageView.backgroundColor = Constants.Colors.dirtyWhite
        
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    public func configure(with model: CircleFeedAuctionModel) {
        self.auctionModel = model
        ImageManager.shared.image(with: model.image) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageView.setImage(image)
            case .failure:
                self?.imageView.image = nil
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
