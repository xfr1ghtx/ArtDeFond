//
//  PaymentView.swift
//  ArtDeFond
//
//  Created by Someone on 23.08.2022.
//

import UIKit
import SnapKit


class PaymentView: UIView {
    
    private lazy var delieveryTitle: UILabel = {
        let label = UILabel()
        label.text = "Данные об оплате"
        label.font = Constants.Fonts.semibold17
        label.textColor = Constants.Colors.darkRed
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.identifier)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    
    
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
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(110)
        }
    }
    
}

extension PaymentView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.identifier, for: indexPath) as! PaymentCell
        cell.configureTableViewCell(titleInfo: payment[indexPath.row].titleInfo, priceInfo: payment[indexPath.row].priceInfo)
        return cell
    }
    
}
