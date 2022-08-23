//
//  InterestViewController.swift
//  ArtDeFond
//
//  Created by developer on 23.08.2022.
//

import UIKit
import SnapKit

protocol InterestViewControllerDelegateToFirstScreen: AnyObject {
    func DidRequestEmail() -> String
    func DidRequestPassword() -> String
}

protocol InterestViewControllerDelegateToSecondScreen: AnyObject{
    func DidRequestAvatar() -> UIImage
    func DidRequestNickname() -> String
    func DidRequestAboutMe() -> String
}

class InterestViewController: UIViewController {
    
    weak var firstScreenDelegate: InterestViewControllerDelegateToFirstScreen?
    
    weak var secondScreenDelegate: InterestViewControllerDelegateToSecondScreen?
    
    private var descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Выберите то, что Вам будет интересно видеть в своей подборке."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Constants.Colors.brown
        label.font = Constants.Fonts.regular15
        return label
    }()
    
    private var picturesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup(){
        
        title = "Интересы"
        
        view.backgroundColor = .white
        
        view.addSubview(descriptionTitle)
        descriptionTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(212)
            make.left.right.equalToSuperview().inset(24)
            //            make.height.equalTo(40)
            //            make.width.equalTo(319)
        }
        
        view.addSubview(picturesCollection)
        createDelegates()
        picturesCollection.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(23)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(409)
            make.width.equalTo(328)
        }
    }
    
    private func picturesCollectionSetup(){
        
        
    }
    
    
    func createDelegates() {
        picturesCollection.dataSource = self
        picturesCollection.delegate = self
    }
    
    @objc
    private func signUpButtonTap(){
        let email = firstScreenDelegate?.DidRequestEmail()
        let password = firstScreenDelegate?.DidRequestPassword()
        let avatar = secondScreenDelegate?.DidRequestAvatar()
        let nickname = secondScreenDelegate?.DidRequestNickname()
        let aboutMe = secondScreenDelegate?.DidRequestAboutMe()
        
        print(email)
        print(password)
        print(avatar)
        print(nickname)
        print(aboutMe)
    }
    
    
    
}

extension InterestViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseIdentifier, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        cell.configureCell(title: modelArray[indexPath.row].title, color: modelArray[indexPath.row].color)
        return cell
    }
    
}

extension InterestViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.width / 2.5, height: ScreenSize.height / 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        
        if cell.backgroundColor == Constants.Colors.darkRed {
            cell.backgroundColor = Constants.Colors.pink
        }
        else{
            cell.backgroundColor = Constants.Colors.darkRed
        }
        
        
        
    }
}

enum ScreenSize {
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    
}
