//
//  AuthViewController.swift
//  ArtDeFond
//
//  Created by developer on 19.08.2022.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding

class AuthViewController: UIViewController {
    
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let contentView = UIView()
    private let iconImageView = UIImageView()
    private let emailLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withoutImage,
                                                                                     keyboardType: .emailAddress,
                                                                                     placeholder: "Введите ваш email"),
                                                     labelText: "Электронная почта")
    private let passwordLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withImageOnRight,
                                                                                        keyboardType: .default,
                                                                                        placeholder: "Введите ваш пароль",
                                                                                        image: Constants.Icons.closeEye),
                                                        labelText: "Пароль")
    
    private let signInButton = CustomButton(viewModel: .init(type: .dark, labelText: "Войти"))
    private let notRegisterLabel = UILabel()
    private let signUpButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        view.backgroundColor = .white
        scrollViewSetup()
        iconImageViewSetup()
        emailLabelTextFieldSetup()
        passwordLabelTextFieldSetup()
        signInButtonSetup()
        notRegisterLabelSetup()
        signUpButtonSetup()
    }
    
    private func scrollViewSetup(){
        view.addSubview(scrollView)
    
        scrollView.keyboardDismissMode = .interactive
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().priority(250)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().priority(250)
            
        }
    }
    
    private func iconImageViewSetup(){
        contentView.addSubview(iconImageView)
        
        iconImageView.image = Constants.Images.logo
        iconImageView.contentMode = .scaleAspectFit
        
        iconImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.25)
            make.width.equalTo(self.view.frame.width * 0.72)
        }
    }
    
    private func emailLabelTextFieldSetup(){
        contentView.addSubview(emailLabelTextField)
        
        emailLabelTextField.snp.makeConstraints{make in
            make.top.equalTo(iconImageView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func passwordLabelTextFieldSetup(){
        contentView.addSubview(passwordLabelTextField)
        
        passwordLabelTextField.snp.makeConstraints{make in
            make.top.equalTo(emailLabelTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func signInButtonSetup(){
        contentView.addSubview(signInButton)
        
        signInButton.snp.makeConstraints{ make in
            make.top.equalTo(passwordLabelTextField.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
    
    private func notRegisterLabelSetup(){
        contentView.addSubview(notRegisterLabel)
        
        notRegisterLabel.text = "Еще нет аккаунта?"
        notRegisterLabel.textAlignment = .center
        notRegisterLabel.textColor = Constants.Colors.middleRed
        notRegisterLabel.font = Constants.Fonts.regular15
        
        notRegisterLabel.snp.makeConstraints{make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func signUpButtonSetup(){
        contentView.addSubview(signUpButton)
        
        signUpButton.setTitle("Регистрация", for: .normal)
        signUpButton.setTitleColor(Constants.Colors.darkRed, for: .normal)
        signUpButton.titleLabel?.font = Constants.Fonts.semibold17
        
        signUpButton.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
        
        signUpButton.snp.makeConstraints{make in
            make.top.equalTo(notRegisterLabel.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func nextScreen(){
        let navCont = UINavigationController.createForAuth()
        navCont.pushViewController(SignUpViewController(), animated: false)
        present(navCont, animated: true)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
