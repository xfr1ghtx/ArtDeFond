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
        
        let images = Array(1...9).map { "image\($0)" }
        models = images.compactMap {
            return Model.init(
                imageName: $0,
                height: .random(in: 100...200),
                width: .random(in: 50...300)
            )
        }
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
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
        
        cell.configure(image: UIImage(named: models[indexPath.row].imageName))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width / 2,
                      height: collectionView.bounds.size.width / 2 * models[indexPath.row].height / models[indexPath.row].width)
    }
}
