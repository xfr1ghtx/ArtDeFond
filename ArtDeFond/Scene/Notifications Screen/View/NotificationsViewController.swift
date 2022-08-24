//
//  NotificationsViewController.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import UIKit
import SnapKit

class NotificationsViewController: UIViewController {
    
    private var viewModel: NotificationsViewModel!
    
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
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.viewModel =  NotificationsViewModel()
        self.viewModel.bindFeedViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
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
        
        switch cellModel.notification.type {
            
        case .yourPictureWasBought, .yourAuctionWasEnded, .youWonAuction, .youBoughtPicture:
            guard let orderId = cellModel.notification.orderId else {
                return
            }
            present(OrderDetailsViewController(viewModel: OrderDetailViewModel(with: orderId)), animated: true)
        case .yourPictureWasBetOn, .yourBetWasBeaten:
            if let pictureId = cellModel.picture?.id {
                present(PictureDetailViewController(viewModel: PictureDetailViewModel(with: pictureId)), animated: true)
            }
        }
    }
}

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notifications.count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCommonTableCell.reusableId) as? NotificationCommonTableCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: NotificationAndPictureModel?
        
        cellModel = viewModel.notifications[indexPath.row]

        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}



