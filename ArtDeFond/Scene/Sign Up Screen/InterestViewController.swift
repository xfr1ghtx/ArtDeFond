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
    
    private let button: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .red
        return bt
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup(){
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
        
        button.snp.makeConstraints{ make in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
    }
    
    private func picturesCollectionSetup(){
        
        
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
