//
//  PictureView.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import UIKit
import SnapKit


class PictureView: UIView {
    
    
    private lazy var pictureImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Constants.Colors.dirtyWhite
        imageView.image = UIImage(named: "picture")
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var pictureTitle: UILabel = {
        let label = UILabel()
        label.text = "Красивое название картины"
        label.font = Constants.Fonts.semibold17
        label.textColor = Constants.Colors.darkRed
        label.numberOfLines = 2
        return label
    }()

    private lazy var sellerUsernameLabel: UILabel = {
        let label = UILabel()
        label.text = "SOMECOOLNAME"
        label.font = Constants.Fonts.semibold11
        label.textColor = Constants.Colors.gray
        return label
    }()

    private lazy var sellerUserImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = Constants.Colors.pink
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "profile")
        return imageView
    }()
    
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        addSubview(pictureImage)
        pictureImage.snp.makeConstraints { make in
            make.height.equalTo(86)
            make.width.equalTo(134)
            make.top.left.bottom.equalToSuperview()
        }
        
        addSubview(pictureTitle)
        pictureTitle.snp.makeConstraints { make in
            make.left.equalTo(pictureImage.snp.right).offset(8)
            
            make.top.right.equalToSuperview()
        }
        
        addSubview(sellerUserImage)
        sellerUserImage.snp.makeConstraints { make in
            make.top.equalTo(pictureTitle.snp.bottom).offset(15)
            make.height.width.equalTo(20)
            make.right.equalToSuperview()
        }
        
        
        addSubview(sellerUsernameLabel)
        sellerUsernameLabel.snp.makeConstraints { make in
            make.right.equalTo(sellerUserImage.snp.left).offset(-10)
            make.top.equalTo(pictureTitle.snp.bottom).offset(20)
        }
    }
    
    
}
