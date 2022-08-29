//
//  CostViewController.swift
//  ArtDeFond
//
//  Created by developer on 24.08.2022.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding

class CostViewController: UIViewController {
    
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let contentView = UIView()
    
    private let sellLabelSwitch = LabelSwitch(text: "Фиксированная цена")
    private let sellLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withImageOnRight,
                                                                                        keyboardType: .numberPad,
                                                                                        placeholder: "1000",
                                                                                        image: Constants.Icons.rub),
                                                        labelText: "Стоимость")
    private let auctionLabelSwitch = LabelSwitch(text: "Аукцион")
    private let uploadPictureButton = CustomButton(viewModel: .init(type: .dark, labelText: "Выложить картину"))
    
    private let viewModel: CostViewModel
    
    init(viewModel: CostViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Стоимость"
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        setup()
    }
    
    private func setup(){
        scrollViewSetup()
        sellLabelSwitchSetup()
        sellLabelTextFieldSetup()
        auctionLabelSwitchSetup()
        uploadPictureButtonSetup()
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
    
    private func sellLabelSwitchSetup(){
        contentView.addSubview(sellLabelSwitch)
        
        sellLabelSwitch.uiswitch.isOn = true
        
        sellLabelSwitch.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
    
    private func sellLabelTextFieldSetup(){
        contentView.addSubview(sellLabelTextField)
        
        sellLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(sellLabelSwitch.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func auctionLabelSwitchSetup(){
        contentView.addSubview(auctionLabelSwitch)
        
        auctionLabelSwitch.uiswitch.isOn = false
        auctionLabelSwitch.uiswitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        auctionLabelSwitch.snp.makeConstraints{ make in
            make.top.equalTo(sellLabelTextField.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func uploadPictureButtonSetup(){
        contentView.addSubview(uploadPictureButton)
        
        uploadPictureButton.addTarget(self, action: #selector(tapOnUploadPictureButton), for: .touchUpInside)
        
        uploadPictureButton.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(auctionLabelSwitch.snp.bottom).offset(40)
            make.height.equalTo(44)
        }
    }
    
    @objc
    private func tapOnUploadPictureButton(){
        if sellLabelTextField.returnText() != "" {
            viewModel.uploadPicture(cost: sellLabelTextField.returnText())
        } else {
            let alert = UIAlertController(title: "Пустое поле", message: "Для добавления картины необходимо указать ее цену.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Хорошо", style: .cancel)
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
    }
    
    @objc
    private func switchChanged(){
        guard auctionLabelSwitch.uiswitch.isOn else {
            return
        }
        
        auctionLabelSwitch.uiswitch.setOn(false, animated: true)
        
        let alert = UIAlertController(title: "Уууупс", message: "Аукционы пока что недоступны, но добавятся в ближайшее время", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

}
