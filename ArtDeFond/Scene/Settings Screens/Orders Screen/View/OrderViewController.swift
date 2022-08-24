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
    
    private var viewModel: OrdersViewModel!
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
    
    
    init(type: OrderType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        
//        viewModel.fetchOrders(type: type) {
//            self.tableView.reloadData()
//        }
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.viewModel =  OrdersViewModel(for: type)
        self.viewModel.bindOrdersViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
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
        let cell = tableView.cellForRow(at: indexPath) as? OrdersTableViewCell
        
        guard
            let cell = cell,
            let orderId = cell.orderModel?.order.id
        else {
            return
        }
        navigationController?.present(OrderDetailsViewController(viewModel: OrderDetailViewModel(with: orderId)), animated: true)
    }
}



extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTableViewCell.reusableId) as? OrdersTableViewCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: OrderAndPictureModel?
        
        cellModel = viewModel.orders[indexPath.row]
//        cellModel = OrderModel(id: "12", picture_image: "22", status: "Доставлено", picture_name: "Восторг", time: "сегодня в 12:00")
        
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        cell.selectionStyle = .none
        return cell
    }
}
