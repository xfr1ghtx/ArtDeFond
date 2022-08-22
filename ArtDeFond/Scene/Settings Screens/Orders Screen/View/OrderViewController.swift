//
//  OrderViewController.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//
import UIKit
import FirebaseAuth
import SnapKit


class OrdersViewController: UIViewController {
    
    private var viewModel: OrdersViewModel
    private var type: OrderType
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: OrdersTableViewCell.reusableId)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    init(type: OrderType, viewModel: OrdersViewModel) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        
        viewModel.fetchOrders(type: type) {
            self.tableView.reloadData()
        }
    }
    
    private func tableViewSetup(){
        switch type {
        case .common:
            title = "Заказы"
        case .purchases:
            title = "Мои покупки"
        case .sales:
            title = "Мои продажи"
        }
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        
        let backImage = UIImage(named: "Back arrow")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backTapped))
        
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalTo(view).offset(10)
        }
    }
    
    @objc
    func backTapped(){
        self.dismiss(animated: true)
    }
}


extension OrdersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTableViewCell.reusableId) as? OrdersTableViewCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: OrderModel?
        
        cellModel = viewModel.orders[indexPath.row]
//        cellModel = OrderModel(id: "12", picture_image: "22", status: "Доставлено", picture_name: "Восторг", time: "сегодня в 12:00")
        
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        return cell
    }
}


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
//        super.prepareForReuse()
//        self.titleLabel.text = nil
//        self.coverImageView.image = nil
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}


struct OrderModel {
    var id: String
    var picture_image: String
    var status: OrderStatus
    var picture_name: String
    var time: Date
}


