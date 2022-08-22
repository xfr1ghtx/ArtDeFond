//
//  SettingsTableViewCell.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation
import UIKit


class SettingsTableCell: UITableViewCell{
    
    static let reusableId = "SettingsTableCell"
    var settingsModel: SettingsModel?
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .white
        imageView.contentMode = .center
        imageView.preferredSymbolConfiguration = .init(pointSize: 23)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Street label"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configure(model: SettingsModel
 ) {
        
        self.settingsModel = model
//        self.image
        self.titleLabel.text = model.title
        self.image.image = model.image?.withTintColor(Constants.Colors.darkRed, renderingMode: .alwaysOriginal)

    
        layout()
    }
    
    
    private func layout(){
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }


//
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(18)
            make.trailing.equalToSuperview()
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



