//
//  AddressTableViewCell.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation
import UIKit


class AddressTableViewCell: UITableViewCell{
    
    static let reusableId = "AddressTableViewCell"
    
    var addressModel: AddressesModel?
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.pink
        imageView.layer.cornerRadius = 51/2
        imageView.clipsToBounds = true
        
        let houseIcon = UIImage(systemName: "house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.contentMode = .center
        imageView.preferredSymbolConfiguration = .init(pointSize: 23)
        imageView.image = houseIcon

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var titleAddressLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Street label"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var detailAddressLabel: UILabel = {
        let label = UILabel()
        
        label.text = "City label"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var postalCodeAddressLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Postal label"
        label.numberOfLines = 1
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    
    
    
    func configure(model: AddressesModel) {
        
        self.addressModel = model
        
        let streetString = "ул. \(model.street), д. \(model.houseNumber)"
        let detailString = "г. \(model.city), \n\(model.district) р-н."
        let postalString = "\(model.postalCode)"
        
        self.titleAddressLabel.text = streetString
        self.detailAddressLabel.text = detailString
        self.postalCodeAddressLabel.text = postalString
    
        layout()
    }
    
    
    private func layout(){
        var imageView : UIImageView
        imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.image = UIImage(named:"Disclosure Indicator")
        self.accessoryView = imageView
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        // TODO: image to center
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.height.equalTo(51)
            make.width.equalTo(51)
            make.top.equalToSuperview().offset(3)
            make.leading.equalToSuperview()
        }


//
        contentView.addSubview(titleAddressLabel)
        titleAddressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(detailAddressLabel)
        detailAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleAddressLabel.snp.bottom).offset(2)
            make.leading.equalTo(image.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(postalCodeAddressLabel)
        postalCodeAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(detailAddressLabel.snp.bottom).offset(2)
            make.leading.equalTo(image.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
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
