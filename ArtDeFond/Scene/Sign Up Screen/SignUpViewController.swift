//
//  SignUpViewController.swift
//  ArtDeFond
//
//  Created by developer on 20.08.2022.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding

class SignUpViewController: UIViewController {
    
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let contentView = UIView()
    
    private let emailLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withoutImage,
                                                                                     keyboardType: .emailAddress,
                                                                                     placeholder: "Email вводи сюда"),
                                                     labelText: "Электронная почта")
    private let passwordLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withImageOnRight,
                                                                                        keyboardType: .default,
                                                                                        placeholder: "Пароль вводи сюда",
                                                                                        image: Constants.Icons.closeEye),
                                                        labelText: "Пароль")
    private let repeatPasswordLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withImageOnRight,
                                                                                              keyboardType: .default,
                                                                                              placeholder: "Еще раз введи пароль сюда",
                                                                                              image: Constants.Icons.closeEye),
                                                              labelText: "Повторите пароль")
    
    private let nextButton = CustomButton(viewModel: .init(type: .dark, labelText: "Далее"))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        title = "Регистрация"
        navigationController?.navigationBar.backItem?.setHidesBackButton(true, animated: false)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItems = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    private func setup(){
        scrollViewSetup()
        emailLabelTextFieldSetup()
        passwordLabelTextFieldSetup()
        repeatPasswordLabelTextFieldSetup()
        nextButtonSetup()
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
    
    private func emailLabelTextFieldSetup(){
        contentView.addSubview(emailLabelTextField)
        
        emailLabelTextField.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(64)
        }
    }
    
    private func passwordLabelTextFieldSetup(){
        contentView.addSubview(passwordLabelTextField)
        
        passwordLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(emailLabelTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(64)
        }
    }
    
    private func repeatPasswordLabelTextFieldSetup(){
        contentView.addSubview(repeatPasswordLabelTextField)
        
        repeatPasswordLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(passwordLabelTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(64)
        }
    }
    
    private func nextButtonSetup(){
        contentView.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        
        nextButton.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
            make.top.equalTo(repeatPasswordLabelTextField.snp.bottom).offset(390)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func tapNextButton(){
        navigationController?.pushViewController(AboutMeViewController(), animated: true)
    }
    
    //250
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
