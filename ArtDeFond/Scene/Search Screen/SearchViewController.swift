//
//  SearchViewController.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private let searchTextField = CustomTextField(viewModel: .init(type: .withImageOnLeft,
                                                                   keyboardType: .default,
                                                                   placeholder: "Поиск картин",
                                                                   image: Constants.Icons.search))
    
    private lazy var picturesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionCellSearch.self, forCellWithReuseIdentifier: CollectionCellSearch.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setup()
    }
    
    private func setup(){
        searchTextFieldSetup()
        picturesCollectionSetup()
    }
    
    private func searchTextFieldSetup(){
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(42)
        }
        
    }
    
    private func picturesCollectionSetup(){
        view.addSubview(picturesCollection)
        
        picturesCollection.dataSource = self
        picturesCollection.delegate = self
        
        picturesCollection.snp.makeConstraints{ make in
            make.top.equalTo(searchTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(409)
            make.width.equalTo(328)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArraySearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellSearch.reuseIdentifier, for: indexPath) as? CollectionCellSearch else { return UICollectionViewCell() }
        cell.configureCell(title: modelArraySearch[indexPath.row].title, imageView: modelArraySearch[indexPath.row].imageView)
        return cell
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.width / 2.5, height: ScreenSize.height/11)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(WaterfallViewController(), animated: true)
    }
    
}
