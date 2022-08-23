//
//  MyPicturesCell.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation
import UIKit


class MyPicturesCell: UITableViewCell{
    
    static let reusableId = "MyPicturesCell"
    
    var pictureModel: ProfilePictureModel?
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.dirtyWhite
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Шедевр"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "21cm x 23cm • 2001l"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular13
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Какая-то часть описания картины. Небольшая."
        label.numberOfLines = 2
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "100$"
        label.numberOfLines = 1
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.bold24
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    func configure(model: ProfilePictureModel
    ) {
        self.pictureModel = model
        let detailsString = "\(model.height)см x \(model.widht)см • \(model.year)"
        
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
        self.priceLabel.text = "\(model.price)$"
        self.detailsLabel.text = detailsString
        
        ImageManager.shared.image(with: model.image) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image.image = image
            case .failure:
                self?.image.image = nil
            }
        }
        
        // image
        
        layout()
    }
    
    
    private func layout(){
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        // TODO: image to center
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(3)
            //            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        // remade with stackview!!!
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(80)
            make.trailing.equalToSuperview()
        }
        //
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(7)
            make.trailing.equalTo(priceLabel.snp.leading)
        }
        
        
        contentView.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(image.snp.trailing).offset(7)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(2)
            make.leading.equalTo(image.snp.trailing).offset(7)
            make.trailing.equalToSuperview()
            //            make.bottom.equalToSuperview()
        }
    }
    
    
    override func prepareForReuse() {
                super.prepareForReuse()
                self.titleLabel.text = nil
                self.image.image = nil
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}
