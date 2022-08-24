//
//  NotificationCommonTableCell.swift
//  ArtDeFond
//
//  Created by Someone on 24.08.2022.
//

import UIKit


class NotificationCommonTableCell: UITableViewCell{
    
    static let reusableId = "NotificationCommonTableCell"
    
    var notificationModel: NotificationAndPictureModel?
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.pink
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Название картины"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Вашу картину купили. Вам необходимо подтвердить отправку."
        label.numberOfLines = 0
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "сегодня в 12:00"
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
    
    
    func configure(model: NotificationAndPictureModel) {
        self.notificationModel = model
        
        var detailString = ""
        switch model.notification.type {
        case .youBoughtPicture:
            detailString = "Вы купили картину. "
        case .youWonAuction:
            detailString = "Вы выиграли аукцион!"
        case .yourBetWasBeaten:
            detailString = "Вашу ставку перебили."
        case .yourAuctionWasEnded:
            detailString = "Аукцион на Вашу картину закончился. Вам необходимо подтвердить отправку."
        case .yourPictureWasBought:
            detailString = "Вашу картину купили. Вам необходимо подтвердить отправку."
        case .yourPictureWasBetOn:
            detailString = "На Вашу картину поставили ставку."
        }
        
        self.detailsLabel.text = detailString
        
        if let picture = model.picture {
            self.titleLabel.text = model.picture?.title
            ImageManager.shared.image(with: picture.image) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.image.setImage(image)
                }
            }
        }
        self.timeLabel.text = model.notification.timeToShow
        
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
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(image.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(2)
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
