//
//  WaterfallViewController.swift
//  ArtDeFond
//
//  Created by Ivan Vislov on 24.08.2022.
//

import CHTCollectionViewWaterfallLayout
import UIKit
import SnapKit

class WaterfallViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    private var viewModel: WaterfallViewModel!
    
    private let searchTextField = CustomTextField(viewModel: .init(type: .withImageOnLeft,
                                                                   keyboardType: .default,
                                                                   placeholder: "Поиск картин",
                                                                   image: Constants.Icons.search))
    private let collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WaterfallCollectionViewCell.self,
                                forCellWithReuseIdentifier: WaterfallCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = viewModel.tagName
        
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        
        let backImage = UIImage(named: "Back arrow")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backTapped))
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        self.viewModel.bindWaterfallViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    init(viewModel: WaterfallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    func backTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(42)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(searchTextField.snp.bottom).offset(13)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterfallCollectionViewCell.identifier,
                                                            for: indexPath) as? WaterfallCollectionViewCell else {
            fatalError()
        }
        let model = viewModel.pictures[indexPath.row]
        
        cell.configure(model: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let model = viewModel.pictures[indexPath.row]
        return CGSize(
            width: collectionView.bounds.size.width / 2,
            height: collectionView.bounds.size.width / 2 * CGFloat(model.height) / CGFloat(model.width)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? WaterfallCollectionViewCell
        guard let id = cell?.model?.id else {
            return
        }
        
        present(PictureDetailViewController(viewModel: .init(with: id)), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
}


