//
//  OrderDetailsViewController.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import Foundation
import UIKit
import SnapKit


class OrderDetailsViewController: UIViewController {
    
    private var viewModel: OrderDetailViewModel
    
    
    private func makeLine() -> UIView {
        let view = UIView()
        view.backgroundColor = Constants.Colors.pink
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    
    private func makeStackView(title: String, view: UIView) -> UIStackView{
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = Constants.Fonts.regular15
        titleLabel.textColor = Constants.Colors.black
        
        let sv = UIStackView(arrangedSubviews: [titleLabel, view])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.distribution = .equalSpacing
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }
    
    lazy var pictureTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = " "
        label.font = Constants.Fonts.semibold17
        label.textColor = Constants.Colors.darkRed
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var sellerImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.pink
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var buyerImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.pink
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var buyerUsernameLabel: UILabel = {
        let label = UILabel()
        
        label.text = " "
        label.textColor = Constants.Colors.gray
        label.font = Constants.Fonts.semibold11
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var sellerUsernameLabel: UILabel = {
        let label = UILabel()
        
        label.text = " "
        label.textColor = Constants.Colors.gray
        label.font = Constants.Fonts.semibold11
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var deliveryInfoTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Данные о доставке"
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    lazy var paymentInfoTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Данные об оплате"
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func titleLabel(with string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        
        return label
    }
    
    private func checkLabel(with string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.textColor = Constants.Colors.gray
        label.font = Constants.Fonts.regular15
        
        return label
    }
    
    lazy var addressInfoLabel: UILabel = {
        let label = UILabel()
        
        label.text = " "
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var indexInfoLabel: UILabel = {
        let label = UILabel()
        
        label.text = " "
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateInfoLabel: UILabel = {
        let label = UILabel()
        
        label.text = " "
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusInfoLabel: UILabel = {
        let label = UILabel()
        
        label.text = " "
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pictureCheckLabel: UILabel = {
        let label = UILabel()
        
        label.text = "₽0.00"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = Constants.Colors.gray
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var saleCheckLabel: UILabel = {
        let label = UILabel()
        
        label.text = "₽0.00"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = Constants.Colors.gray
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var delivetyCheckLabel: UILabel = {
        let label = UILabel()
        
        label.text = "₽0.00"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = Constants.Colors.gray
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var taxCheckLabel: UILabel = {
        let label = UILabel()
        
        label.text = "₽0.00"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = Constants.Colors.gray
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Всего"
        label.numberOfLines = 1
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        
        label.text = "₽0.00"
        label.numberOfLines = 1
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    init(viewModel: OrderDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callToViewModelForUIUpdate()
        self.layout()
    }
    
    func callToViewModelForUIUpdate(){
        self.viewModel.bindOrderDetailViewModelToController = {
            self.configureView()
            
        }
    }
    
    private func configureView() {
        guard let model = viewModel.order else {
            return
        }
        
        self.pictureTitleLabel.text = model.picture?.title
        if let image = model.picture?.image {
            ImageManager.shared.image(with: image) { result in
                switch result {
                case .failure( _):
                    self.pictureImageView.image = nil
                case .success(let image):
                    self.pictureImageView.image = image
                }
            }
        }
        
        self.sellerUsernameLabel.text = model.sellerUser?.nickname.uppercased()
        if let image = model.sellerUser?.avatar_image {
            ImageManager.shared.image(with: image) { result in
                switch result {
                case .failure( _):
                    self.sellerImageView.image = nil
                case .success(let image):
                    self.sellerImageView.image = image
                }
            }
        }
        
        if let address = model.address {
            self.addressInfoLabel.text = "г.\(address.city) ул.\(address.street) д.\(address.house_number) кв.\(address.apartment_number)"
            self.indexInfoLabel.text = "\(address.post_index)"
        }
        self.dateInfoLabel.text = model.order.time.timeToShow()
        
        let statusString: String
        switch model.order.status {
            
        case .booked:
            statusString = "Ожидает оплаты"
        case .purchased:
            statusString = "Ожидает отправки"
        case .sent:
            statusString = "Отправлено"
        case .delivered:
            statusString = "Доставлено"
        }
        
        self.statusInfoLabel.text = statusString
        
        self.buyerUsernameLabel.text = model.buyerUser?.nickname.uppercased()
        if let image = model.buyerUser?.avatar_image {
            ImageManager.shared.image(with: image) { result in
                switch result {
                case .failure( _):
                    self.buyerImageView.image = nil
                case .success(let image):
                    self.buyerImageView.image = image
                }
            }
        }
        
        self.pictureCheckLabel.text = model.picture?.price.toRubles()
        self.totalLabel.text = model.picture?.price.toRubles()
        
        
    }
    
    private func layout() {
        
        let padding = 40
        
        let scrollView = UIScrollView()
        let containerView = UIView()
        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        containerView.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(padding)
            make.height.equalTo(85)
            make.width.equalTo(135)
        }
        
        containerView.addSubview(pictureTitleLabel)
        pictureTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(9)
        }
        
        
        containerView.addSubview(sellerImageView)
        sellerImageView.snp.makeConstraints { make in
            make.bottom.equalTo(pictureImageView.snp.bottom)
            make.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        containerView.addSubview(sellerUsernameLabel)
        sellerUsernameLabel.snp.makeConstraints { make in
            make.trailing.equalTo(sellerImageView.snp.leading).offset(-5)
            make.centerY.equalTo(sellerImageView.snp.centerY)
        }
        
        containerView.addSubview(deliveryInfoTitleLabel)
        deliveryInfoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureImageView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(padding)
        }
        
        let addressTitle = titleLabel(with: "Адрес")
        containerView.addSubview(addressTitle)
        addressTitle.snp.makeConstraints { make in
            make.top.equalTo(deliveryInfoTitleLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(addressInfoLabel)
        addressInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryInfoTitleLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(addressTitle.snp.trailing).offset(10)
        }
        
        let indexTitle = titleLabel(with: "Индекс")
        containerView.addSubview(indexTitle)
        indexTitle.snp.makeConstraints { make in
            make.top.equalTo(addressInfoLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(indexInfoLabel)
        indexInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(addressInfoLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(indexTitle.snp.trailing).offset(10)
        }
        
        let dateTitle = titleLabel(with: "Дата заказа")
        containerView.addSubview(dateTitle)
        dateTitle.snp.makeConstraints { make in
            make.top.equalTo(indexInfoLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(dateInfoLabel)
        dateInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(indexInfoLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(dateTitle.snp.trailing).offset(10)
        }
        
        let statusTitle = titleLabel(with: "Статус")
        containerView.addSubview(statusTitle)
        statusTitle.snp.makeConstraints { make in
            make.top.equalTo(dateInfoLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(statusInfoLabel)
        statusInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(dateInfoLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(statusTitle.snp.trailing).offset(10)
        }
        
        let buyerTitle = titleLabel(with: "Покупатель")
        containerView.addSubview(buyerTitle)
        buyerTitle.snp.makeConstraints { make in
            make.top.equalTo(statusInfoLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(buyerImageView)
        containerView.addSubview(buyerUsernameLabel)
        buyerUsernameLabel.snp.makeConstraints { make in
            make.top.equalTo(statusInfoLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
        }
        buyerImageView.snp.makeConstraints { make in
            make.centerY.equalTo(buyerUsernameLabel.snp.centerY)
            make.trailing.equalTo(buyerUsernameLabel.snp.leading).offset(-5)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        containerView.addSubview(paymentInfoTitleLabel)
        paymentInfoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(buyerImageView.snp.bottom).offset(49)
            make.leading.equalToSuperview().offset(padding)
        }
        
        let pictureCheckTitle = checkLabel(with: "Картина")
        let deliveryCheckTitle = checkLabel(with: "Доставка")
        let taxCheckTitle = checkLabel(with: "Налог")
        let saleCheckTitle = checkLabel(with: "Скидка")
        
        
        containerView.addSubview(pictureCheckTitle)
        pictureCheckTitle.snp.makeConstraints { make in
            make.top.equalTo(paymentInfoTitleLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(pictureCheckLabel)
        pictureCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(paymentInfoTitleLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(pictureCheckTitle.snp.trailing).offset(10)
        }
        
        containerView.addSubview(deliveryCheckTitle)
        deliveryCheckTitle.snp.makeConstraints { make in
            make.top.equalTo(pictureCheckLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(delivetyCheckLabel)
        delivetyCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureCheckLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(deliveryCheckTitle.snp.trailing).offset(10)
        }
        
        containerView.addSubview(taxCheckTitle)
        taxCheckTitle.snp.makeConstraints { make in
            make.top.equalTo(deliveryCheckTitle.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(taxCheckLabel)
        taxCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(delivetyCheckLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(taxCheckTitle.snp.trailing).offset(10)
        }
        
        containerView.addSubview(saleCheckTitle)
        saleCheckTitle.snp.makeConstraints { make in
            make.top.equalTo(taxCheckLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(padding)
        }
        
        containerView.addSubview(saleCheckLabel)
        saleCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(taxCheckLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalTo(saleCheckTitle.snp.trailing).offset(10)
        }
        
        
        let line = makeLine()
        containerView.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(saleCheckLabel.snp.bottom).offset(25)
            make.trailing.equalToSuperview().inset(padding)
            make.leading.equalToSuperview().inset(padding)
            make.height.equalTo(1)
        }
        
        containerView.addSubview(totalTitleLabel)
        totalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(padding)
        }
        
        containerView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(25)
            make.trailing.equalToSuperview().inset(padding)
        }
    }
}








