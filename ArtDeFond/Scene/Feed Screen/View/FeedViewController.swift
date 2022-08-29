//
//  FeedViewController.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: FeedViewModel!
    
    lazy var feedTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(PictureFeedTableCell.self, forCellReuseIdentifier: PictureFeedTableCell.reusableId)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 240
        tableView.addSubview(refreshControll)
        
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
    
    
    lazy var refreshControll: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = Constants.Colors.darkRed
        
        refresh.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)
        
        return refresh
    }()
    
    
    @objc
    func refreshing(){
        callToViewModelForUIUpdate()
    }
    
    
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feedTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.viewModel =  FeedViewModel()
        self.viewModel.bindFeedViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.feedTableView.reloadData()
            self.collectionView.reloadData()
            self.refreshControll.endRefreshing()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(collectionView)
        // move to tableView header
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(64)
        }
        
        view.addSubview(feedTableView)
        feedTableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    
    private func setup(){
        title = "Лента"
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
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
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.auctions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AuctionCollectionViewCell.identifier, for: indexPath) as!
        AuctionCollectionViewCell
        cell.configure(with: viewModel.auctions[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? PictureFeedTableCell
        guard
            let cell = cell,
            let pictureId = cell.pictureModel?.picture.id
        else {
            return
        }
        
        let vc = PictureDetailViewController(viewModel: PictureDetailViewModel(with: pictureId))
        self.present(vc, animated: true)
        
    }
}


//MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pictures.count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PictureFeedTableCell.reusableId) as? PictureFeedTableCell
        else {
            fatalError("unexpected cell")
        }
        
        if !self.refreshControll.isRefreshing {
            let cellModel: PictureWithAuthorModel?
            
            cellModel = viewModel.pictures[indexPath.row]
            
            if let cellModel = cellModel {
                cell.configure(model: cellModel)
                
            }
            cell.selectionStyle = .none 
        }
            return cell
        }
    }
    
    
    
    
