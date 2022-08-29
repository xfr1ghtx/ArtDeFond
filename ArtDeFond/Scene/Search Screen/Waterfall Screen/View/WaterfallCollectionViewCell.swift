//
//  WaterfallCollectionViewCell.swift
//  ArtDeFond
//
//  Created by Ivan Vislov on 24.08.2022.
//

import UIKit

class WaterfallCollectionViewCell: UICollectionViewCell {
    static let identifier = "WaterfallCollectionViewCell"
    var model: Picture?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(model: Picture) {
        self.model = model
        ImageManager.shared.image(with: model.image) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                self.imageView.image = image
            }
        }
    }
}
