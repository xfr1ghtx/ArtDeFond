//
//  WaterfallViewController.swift
//  ArtDeFond
//
//  Created by Ivan Vislov on 24.08.2022.
//

import CHTCollectionViewWaterfallLayout
import UIKit
import SnapKit

// переписать на реальные модели с бэка
// верстка
//бэк кнопка

class WaterfallViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
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
    
    struct Model {
        let imageName: String
        let height: CGFloat
        let width: CGFloat
    }
    
    private var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Результат"
        navigationItem.backButtonTitle = ""
        
        let images = Array(1...22).map { "image\($0)" }
        models = images.compactMap {
            return Model.init(
                imageName: $0,
                height: .random(in: 100...170),
                width: .random(in: 50...200)
            )
        }
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(55)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints{ make in
            make.top.equalTo(collectionView).offset(-50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(42)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        collectionView.frame = view.bounds
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterfallCollectionViewCell.identifier,
                                                            for: indexPath) as? WaterfallCollectionViewCell else {
            fatalError()
        }
        if (indexPath.item != 7){
            cell.configure(image: UIImage(named: models[indexPath.row].imageName))
        }
        else {
            cell.configure(image: UIImage(named: "imageA"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return indexPath.item == 7 ? CGSize(width: 1500, height: 1200) : CGSize(width: collectionView.bounds.size.width / 2,
                                                                                height: collectionView.bounds.size.width / 2 * models[indexPath.row].height / models[indexPath.row].width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 7{
            present(PictureDetailViewController(viewModel: .init(with: "0C91A961-5B0A-4099-96C7-7F467FD75413")), animated: true)
        }
    }
}


