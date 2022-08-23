//
//  PictureFeedCell.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import UIKit
import SnapKit


class PictureFeedCell: UITableViewCell{
    
    static let reusableId = "PictureFeedCell"
    
    var pictureModel: FeedPictureModel?
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.dirtyWhite
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var authorImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.pink
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "pic")
        imageView.sizeToFit()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Title label"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Author label"
        label.numberOfLines = 1
        label.font = Constants.Fonts.semibold11
        label.textColor = Constants.Colors.gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    

    func configure(model: FeedPictureModel) {
        self.pictureModel = model
        
        self.titleLabel.text = model.title
        self.authorLabel.text = model.authorName.uppercased()
        
        ImageManager.shared.image(with: model.image) { [weak self] result in
            switch result {
            case .success(let image):
                self?.coverImageView.image = image
            case .failure:
                self?.coverImageView.image = nil
            }
        }
        
        layout()
    }
    
    
    private func layout(){
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        contentView.addSubview(authorImageView)
        authorImageView.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.height.equalTo(184)
            make.top.equalTo(authorImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(authorImageView.snp.centerY)
            make.leading.equalTo(authorImageView.snp.trailing).offset(6)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)

        }
    }
    
    
    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.titleLabel.text = nil
//        self.coverImageView.image = nil
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}

