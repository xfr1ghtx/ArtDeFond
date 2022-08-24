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
        collectionView.register(CollectionCellSignUp.self, forCellWithReuseIdentifier: CollectionCellSignUp.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let nextButton = CustomButton(viewModel: .init(type: .dark,
                                                           labelText: "Зарегистрироваться"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup(){
        nextButtonSetup()
        
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
        picturesCollectionSetup()
        picturesCollection.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(23)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(409)
            make.width.equalTo(328)
        }
    }
    
    private func picturesCollectionSetup(){
        picturesCollection.dataSource = self
        picturesCollection.delegate = self
    }
    
    private func nextButtonSetup(){
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
        
        nextButton.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
        }
    }
    
    @objc
    private func signUpButtonTap(){
        let email = firstScreenDelegate?.DidRequestEmail()
        let password = firstScreenDelegate?.DidRequestPassword()
        let avatar = secondScreenDelegate?.DidRequestAvatar()
        let nickname = secondScreenDelegate?.DidRequestNickname()
        let aboutMe = secondScreenDelegate?.DidRequestAboutMe()
        
        var imageString = ""
        
        ImageManager.shared.upload(image: avatar ?? UIImage()) { result in
            switch result{
            case.success(let resultImageString):
                imageString = resultImageString
                break
            case.failure(let error):
                print(error)
                break
            }
            
            AuthManager.shared.signUp(withEmail: email ?? "test@test.ru", withPassword: password ?? "password", image: imageString, nickname: nickname ?? "CoolBoy", description: aboutMe ?? "I am very cool artist", tags: []) { result in
                switch result{
                case.success(let result):
                    NotificationCenter.default.post(name: NSNotification.Name("InterestViewController.signUp.succes.ArtDeFond"), object: nil)
                    
                case .failure(let error):
                    print(error)
                }
                
            }
            
            
        }
        
        
        
    }
}

extension InterestViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellSignUp.reuseIdentifier, for: indexPath) as? CollectionCellSignUp else { return UICollectionViewCell() }
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

