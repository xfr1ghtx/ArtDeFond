//
//  OrdersTableViewCell.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import UIKit

class OrdersTableViewCell: UITableViewCell{
    
    static let reusableId = "OrdersTableViewCell"
    
    var orderModel: OrderModel?
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.pink
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true

        imageView.image = UIImage(named: "pic")

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
    
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        
        label.text = "City label"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeLabel: UILabel = {
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
    
    
    
    
    
    func configure(model: OrderModel
 ) {
        
        self.orderModel = model
        
        self.titleLabel.text = model.picture_name
        self.statusLabel.text = "\(model.status)"
        self.timeLabel.text = "\(model.time)"
        // order image
    
        layout()
    }
    
    
    private func layout(){
        var imageView : UIImageView
        imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.image = UIImage(named:"Disclosure Indicator")
        self.accessoryView = imageView
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.height.equalTo(51)
            make.width.equalTo(51)
            make.top.equalToSuperview().offset(3)
            make.leading.equalToSuperview()
        }


        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(image.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(2)
            make.leading.equalTo(image.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}

