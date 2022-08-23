//
//  OrderInfoViewController.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import Foundation


import UIKit
import SnapKit

class OrderViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var pictureView: PictureView = {
        let view = PictureView()
        return view
    }()
    
    private lazy var delieveryView: DelieveryView = {
        let view = DelieveryView()
        return view
    }()
    
    private lazy var paymentView: PaymentView = {
        let view = PaymentView()
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.darkRed
        return view
    }()
    
    
    private lazy var totalAmount: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        label.text = "Итого"
        return label
    }()
    
    private lazy var amountSummary: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        label.text = "$ 000,00"
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить статус", for: .normal)
        button.backgroundColor = Constants.Colors.darkRed
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalAmount, amountSummary])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [delieveryView, paymentView, lineView, horizontalStack])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createLeftButton()
        createLayout()
    }
    
    
    func createLayout() {
        
        view.addSubview(statusButton)
        statusButton.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        view.addSubview(pictureView)
        pictureView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom).offset(20)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.bottom.equalTo(statusButton.snp.top).inset(-20)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

    }
    
    func createLeftButton() {
        let nav = self.navigationController?.navigationBar
        nav?.isHidden = false
        nav?.tintColor = Constants.Colors.darkRed
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.darkRed]
        title = "Информация о заказе"
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(openNewScreen))
        self.navigationItem.leftBarButtonItem  = leftButton
    }
    
    @objc func openNewScreen() {
        
    }
}



import UIKit
import SnapKit

class DelieveryCell: UITableViewCell {

    static let identifier = "DelieveryCell"

    private var titleInfo: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = Constants.Fonts.regular15
        return label
    }()
    
    private var userInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.regular15
        label.alpha = 0.5
        return label
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        return imageView
    }()
    
    private var hasImage: Bool = false


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public func configureTableViewCell(titleInfo: String, userInfo: String, hasImage: Bool) {
        self.titleInfo.text = titleInfo
        self.userInfo.text = userInfo
        self.hasImage = hasImage
        
        contentView.addSubview(self.userInfo)
        self.userInfo.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(2)
            make.bottom.equalToSuperview().inset(2)
            make.right.equalToSuperview()
        }
        
        contentView.addSubview(self.titleInfo)
        self.titleInfo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2)
            make.left.equalToSuperview()
        }
        
        if self.hasImage {
            self.userInfo.font = Constants.Fonts.regular13
            self.userInfo.textColor = .gray
            self.userInfo.alpha = 1
            
            self.userInfo.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview()
            }
            
            self.titleInfo.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview()
            }
            
            contentView.addSubview(profileImage)
            profileImage.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.width.equalTo(20)
                make.right.equalTo(self.userInfo.snp.left).inset(-10)
            }
        }
    }
}

//class DelieveryModel {
//    var titleInfo: String
//    var userInfo: String
//    var hasImage: Bool
//    
//    init(titleInfo: String, userInfo: String, hasImage: Bool) {
//        self.titleInfo = titleInfo
//        self.userInfo = userInfo
//        self.hasImage = hasImage
//    }
//}
//
//let model: [DelieveryModel] = [
//    DelieveryModel(titleInfo: "Адрес", userInfo: "г. Москва, ул. Морозная, д. 105, кв 45", hasImage: false),
//    DelieveryModel(titleInfo: "Индекс", userInfo: "100002",  hasImage: false),
//    DelieveryModel(titleInfo: "Дата заказа", userInfo: "22.09.09",  hasImage: false),
//    DelieveryModel(titleInfo: "Статус", userInfo: "В пути",  hasImage: false),
//    DelieveryModel(titleInfo: "Получатель", userInfo: "SOMECOOLNAME",  hasImage: true)
//]


class DelieveryView: UIView {
    
    private lazy var delieveryTitle: UILabel = {
        let label = UILabel()
        label.text = "Данные о доставке"
        label.font = Constants.Fonts.semibold17
        label.textColor = Constants.Colors.darkRed
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(DelieveryCell.self, forCellReuseIdentifier: DelieveryCell.identifier)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        addSubview(delieveryTitle)
        delieveryTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(delieveryTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
            make.left.right.equalToSuperview()
        }
    }
    
}

extension DelieveryView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DelieveryCell.identifier, for: indexPath) as! DelieveryCell
        cell.configureTableViewCell(titleInfo: model[indexPath.row].titleInfo, userInfo: model[indexPath.row].userInfo, hasImage: model[indexPath.row].hasImage)
        return cell
    }
    
    
}


class PaymentCell: UITableViewCell {

    static let identifier = "PaymentCell"

    private var titleInfo: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = Constants.Fonts.regular15
        return label
    }()
    
    private var priceInfo: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = Constants.Fonts.regular15
        label.alpha = 0.5
        return label
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        return imageView
    }()
    
    private var hasImage: Bool = false


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public func configureTableViewCell(titleInfo: String, priceInfo: String) {
        self.titleInfo.text = titleInfo
        self.priceInfo.text = priceInfo
        
        contentView.addSubview(self.priceInfo)
        self.priceInfo.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(2)
            make.right.equalToSuperview()
        }
        
        contentView.addSubview(self.titleInfo)
        self.titleInfo.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(2)
            make.left.equalToSuperview()
        }
    }
}





//class PaymentModel {
//    var titleInfo: String
//    var priceInfo: String
//
//    init(titleInfo: String, priceInfo: String) {
//        self.titleInfo = titleInfo
//        self.priceInfo = priceInfo
//    }
//}
//
//let payment: [PaymentModel] = [
//    PaymentModel(titleInfo: "Картина", priceInfo: "$ 000,00"),
//    PaymentModel(titleInfo: "Доставка", priceInfo: "$ 000,00"),
//    PaymentModel(titleInfo: "Возможно налог?", priceInfo: "$ 000,00"),
//    PaymentModel(titleInfo: "Скидка всем покупателям", priceInfo: "$ 000,00")
//]


//class PaymentView: UIView {
//
//    private lazy var delieveryTitle: UILabel = {
//        let label = UILabel()
//        label.text = "Данные об оплате"
//        label.font = Constants.Fonts.semibold17
//        label.textColor = Constants.Colors.darkRed
//        return label
//    }()
//
//    private(set) lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .clear
//        tableView.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.identifier)
//        tableView.dataSource = self
//        tableView.separatorStyle = .none
//        tableView.allowsSelection = false
//        tableView.isScrollEnabled = false
//        return tableView
//    }()
//
//
//
//    init() {
//        super.init(frame: .zero)
//        commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func commonInit() {
//        addSubview(delieveryTitle)
//        delieveryTitle.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.left.equalToSuperview()
//        }
//
//        addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(delieveryTitle.snp.bottom).offset(10)
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(110)
//        }
//    }
//
//}
//
//extension PaymentView: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return payment.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.identifier, for: indexPath) as! PaymentCell
//        cell.configureTableViewCell(titleInfo: payment[indexPath.row].titleInfo, priceInfo: payment[indexPath.row].priceInfo)
//        return cell
//    }
//
//}


//class PictureView: UIView {
//    
//    
//    private lazy var pictureImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = Constants.Colors.dirtyWhite
//        imageView.image = UIImage(named: "picture")
//        return imageView
//    }()
//
//    private lazy var pictureTitle: UILabel = {
//        let label = UILabel()
//        label.text = "Красивое название картины"
//        label.font = Constants.Fonts.semibold17
//        label.textColor = Constants.Colors.darkRed
//        label.numberOfLines = 2
//        return label
//    }()
//
//    private lazy var someCoolNameTitle: UILabel = {
//        let label = UILabel()
//        label.text = "SOMECOOLNAME"
//        label.font = Constants.Fonts.semibold11
//        label.textColor = Constants.Colors.gray
//        return label
//    }()
//
//    private lazy var profileImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "profile")
//        return imageView
//    }()
//    
//    
//    init() {
//        super.init(frame: .zero)
//        commonInit()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func commonInit() {
//        addSubview(pictureImage)
//        pictureImage.snp.makeConstraints { make in
//            make.height.equalTo(86)
//            make.width.equalTo(134)
//            make.top.left.bottom.equalToSuperview()
//        }
//        
//        addSubview(pictureTitle)
//        pictureTitle.snp.makeConstraints { make in
//            make.left.equalTo(pictureImage.snp.right).offset(8)
//            make.top.right.equalToSuperview()
//        }
//        
//        addSubview(profileImage)
//        profileImage.snp.makeConstraints { make in
//            make.top.equalTo(pictureTitle.snp.bottom).offset(15)
//            make.height.width.equalTo(20)
//            make.right.equalToSuperview()
//        }
//        
//        
//        addSubview(someCoolNameTitle)
//        someCoolNameTitle.snp.makeConstraints { make in
//            make.right.equalTo(profileImage.snp.left).offset(-10)
//            make.top.equalTo(pictureTitle.snp.bottom).offset(20)
//        }
//    }
//    
//    
//}

