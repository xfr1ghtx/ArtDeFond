//
//  AddressesViewController.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation
import UIKit
import SnapKit

class AddressesViewController: UIViewController {
    
    private var viewModel: AddressesViewModel
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.reusableId)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: AddressesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AddressesCollectionVC is loaded")
        tableViewSetup()
        
        viewModel.fetchAdresses {
            self.tableView.reloadData()
        }
    }
    
    private func tableViewSetup(){
        
        view.backgroundColor = .white
        
        title = "Адреса"
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        
        let backImage = UIImage(named: "Back arrow")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backTapped))
        
        let plusImage = UIImage(named: "Plus")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage, style: .done, target: self, action: #selector(addTapped))
        
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
        print("back tapped")
        self.dismiss(animated: true)
    }
    
    @objc
    func addTapped(){
        print("add tapped")
    }
}


extension AddressesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



extension AddressesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reusableId) as? AddressTableViewCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: AddressesModel?
        
        cellModel = viewModel.addresses[indexPath.row]
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        return cell
    }
}





