//
//  ProfileViewController.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import UIKit
import SnapKit

// move tableHeaderView to header of the table section ???
// also dont forget to change trailing and leading constraints
// keep in mind leading padding in collection view

// loader


class ProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: ProfileViewModel!
    
    lazy var tableHeaderView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(MyPicturesCell.self, forCellReuseIdentifier: MyPicturesCell.reusableId)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 64, height: 64)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(AuctionCollectionViewCell.self, forCellWithReuseIdentifier: AuctionCollectionViewCell.identifier)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.pink
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = true
        view.image = UIImage(named: "whiteProfile")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var balanceDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Текущий баланс"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "₽1.01"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = Constants.Fonts.bold30
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "SOMEONE"
        label.numberOfLines = 1
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
//        label.text = "Прекрасное описание чудесного человека с красивым именем. История данной личности останется неразгаданной загадкой. Это все, что об этом можно сказать."
        label.text = ""
        label.numberOfLines = 0
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var auctionsTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Активные аукционы"
        label.numberOfLines = 1
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var picturesTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Мои картины"
        
        label.numberOfLines = 1
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Профиль"
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes

        setup()
        callToViewModelForUIUpdate()
        
       
    }
    
    func callToViewModelForUIUpdate(){
        self.viewModel.bindProfileViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.configureUser()
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
        
    }
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
        
    }
    
    
    private func configureUser(){
        print(viewModel.user)
//        nicknameLabel.fadeTransition(0.4)
        nicknameLabel.text = viewModel.user?.nickname.uppercased()
//        descriptionLabel.fadeTransition(0.4)
        descriptionLabel.text = viewModel.user?.description
        
        guard let balance = viewModel.user?.account_balance else {
            return
        }
        balanceAmountLabel.text = balance.toRubles()
        
    }
    
    @available(iOS 15.0, *) // fix it later
    @objc
    private func addTapped() {
        let settingsViewController = UserSettingsViewController()
        if let sheet = settingsViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        present(settingsViewController, animated: true) {
//            self.newsTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func layout(){
        view.backgroundColor = .white
        
        let menuImage = UIImage(named: "MenuIcon")

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: menuImage, style: .done, target: self, action: #selector(addTapped))
        
        view.addSubview(tableHeaderView)
        tableHeaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            
        }
        
        tableHeaderView.addSubview(balanceView)
        balanceView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(110)
        }
        
        balanceView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(64)
            make.width.equalTo(64)
            make.leading.equalToSuperview().offset(34)
        }
        
        balanceView.addSubview(balanceDescriptionLabel)
        balanceDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(34)
            make.top.equalToSuperview().offset(25)
        }
        
        balanceView.addSubview(balanceAmountLabel)
        balanceAmountLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(32)
            make.top.equalTo(balanceDescriptionLabel.snp.bottom).offset(5)
        }
        
        tableHeaderView.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(balanceView.snp.bottom).offset(28)
        }
        
        tableHeaderView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(nicknameLabel.snp.bottom).offset(15)
        }
        
        
        tableHeaderView.addSubview(auctionsTitleLabel)
        auctionsTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            
        }
        
        
        
        tableHeaderView.addSubview(collectionView)
        // move to tableView header
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(auctionsTitleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(64)
        }
        
        
        tableHeaderView.addSubview(picturesTitleLabel)
        picturesTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableHeaderView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view).offset(10)
        }
    }
    
    private func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = false 
    }
}




//MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? AuctionCollectionViewCell
        
        guard
            let cell = cell,
            let auctionId = cell.auctionModel?.id
        else { return }
        present(PictureDetailViewController(viewModel: PictureDetailViewModel(with: auctionId)), animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.auctions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AuctionCollectionViewCell.identifier, for: indexPath) as! AuctionCollectionViewCell
        cell.configure(with: viewModel.auctions[indexPath.row])
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? MyPicturesCell
        
        guard
            let cell = cell,
            let pictureId = cell.pictureModel?.id
        else { return }
        present(PictureDetailViewController(viewModel: PictureDetailViewModel(with: pictureId)), animated: true)
    }
}



extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.pictures.count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPicturesCell.reusableId) as? MyPicturesCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: Picture?
        
        cellModel = viewModel.pictures[indexPath.row]
        
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        return cell
    }
}



