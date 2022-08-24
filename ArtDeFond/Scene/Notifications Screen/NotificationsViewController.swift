//
//  NotificationsViewController.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import UIKit
import SnapKit

class NotificationsViewController: UIViewController {
    
    private var viewModel: NotificationsViewModel
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(NotificationCommonTableCell.self, forCellReuseIdentifier: NotificationCommonTableCell.reusableId)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 240
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchNotifications {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewModel.fetchNotifications {
            self.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: NotificationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private func setup(){
        view.backgroundColor = .white
        
        title = "Уведомления"
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(25)
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? NotificationCommonTableCell
        
        guard
            let cell = cell,
            let cellModel = cell.notificationModel
        else {
            return
        }
        
        switch cellModel.type {
            
        case .yourPictureWasBought, .yourAuctionWasEnded, .youWonAuction, .youBoughtPicture:
            guard let orderId = cellModel.orderId else {
                return
            }
            
            present(OrderDetailsViewController(viewModel: OrderDetailViewModel(with: orderId)), animated: true)
            
            
            // to OrderViewController via cellModel.orderId
        case .yourPictureWasBetOn, .yourBetWasBeaten:
            let pictureId = cellModel.pictureId
            present(PictureDetailViewController(viewModel: PictureDetailViewModel(with: pictureId)), animated: true)
        }
    }
}

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCommonTableCell.reusableId) as? NotificationCommonTableCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: NotificationModel? // change to NotificationModel
        
        cellModel = viewModel.notifications[indexPath.row]
        
        //        cellModel = NotificationModel(id: "some id", userId: "dd", pictureId: "dd", type: .youBoughtPicture, orderId: "44", orderStatus: .booked, time: Date.now)
        //
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        return cell
    }
    
    
}

struct NotificationModel: Codable {
    let id: String
    let userId: String
    let pictureId: String // picture?
    let type: NotificationType
    let orderId: String? // order?
    let orderStatus: OrderStatus? // ??
    let time: Date
    
    var timeToShow: String? {
        get {
            return timeToShow(from: time)
        }
    }
    
    var pictureInfo: PicInfo? {
        get {
            return pictureInfo(with: pictureId)
        }
    }
    
    func pictureInfo(with pictureId: String) -> PicInfo? {
        var info: PicInfo? = nil
        PicturesManager.shared.getPictureWithId(with: pictureId) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let picture):
                info = PicInfo(title: picture.title, image: picture.image)
            }
        }
        return info
    }
    
    func timeToShow(from date: Date) -> String? {
        
        if date.isToday() {
            let minsBetween = Date.minutesBetweenDates(date, Date())
            if minsBetween < 60 {
                let minsInt = Int(minsBetween)
                //FIXIT: локализация не работает!!!
                let string = " мин назад"
                return "\(minsInt)" + string
            } else {
                let time = date.dateAndTimetoString(format: "hh:mm a")
                return "сегодня в " + time
            }
        }
        if date.isYesterday(){
            let time = date.dateAndTimetoString(format: "hh:mm a")
            return "вчера в " + time
        }
        return date.dateAndTimetoString(format: "dd MMM' в 'hh:mm a")
    }
    
    struct PicInfo {
        let title: String
        let image: String
    }
    
}

enum NotificationType: String, Codable {
    case yourPictureWasBought
    case yourPictureWasBetOn
    case yourAuctionWasEnded
    
    case yourBetWasBeaten
    case youWonAuction
    case youBoughtPicture
}


class NotificationCommonTableCell: UITableViewCell{
    
    static let reusableId = "NotificationCommonTableCell"
    
    var notificationModel: NotificationModel?
    
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
    
    
    func configure(model: NotificationModel) {
        self.notificationModel = model
        
        var detailString = ""
        switch model.type {
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
        self.titleLabel.text = model.pictureId
//        self.titleLabel.text = model.pictureInfo?.title // change that!!
        
        //        ImageManager.shared.image(with: model.pictureImageName) { [weak self] result in
        //            switch result {
        //            case .success(let image):
        //                self?.image.image = image
        //            case .failure:
        //                self?.image.image = nil
        //            }
        //        }
        self.timeLabel.text = model.timeToShow // change that too
        
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
        //        super.prepareForReuse()
        //        self.titleLabel.text = nil
        //        self.coverImageView.image = nil
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}



