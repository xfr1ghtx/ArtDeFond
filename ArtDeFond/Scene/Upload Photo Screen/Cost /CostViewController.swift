//
//  CostViewController.swift
//  ArtDeFond
//
//  Created by developer on 24.08.2022.
//

import UIKit
import SnapKit

class CostViewController: UIViewController {
    
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
        sellLabelSwitchSetup()
        sellLabelTextFieldSetup()
        auctionLabelSwitchSetup()
        uploadPictureButtonSetup()
    }
    
    private func sellLabelSwitchSetup(){
        view.addSubview(sellLabelSwitch)
        
        sellLabelSwitch.uiswitch.isOn = true
        
        sellLabelSwitch.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
    
    private func sellLabelTextFieldSetup(){
        view.addSubview(sellLabelTextField)
        
        sellLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(sellLabelSwitch.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func auctionLabelSwitchSetup(){
        view.addSubview(auctionLabelSwitch)
        
        auctionLabelSwitch.uiswitch.isOn = false
        auctionLabelSwitch.uiswitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        auctionLabelSwitch.snp.makeConstraints{ make in
            make.top.equalTo(sellLabelTextField.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func uploadPictureButtonSetup(){
        view.addSubview(uploadPictureButton)
        
        uploadPictureButton.addTarget(self, action: #selector(tapOnUploadPictureButton), for: .touchUpInside)
        
        uploadPictureButton.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
    }
    
    @objc
    private func tapOnUploadPictureButton(){
        viewModel.uploadPicture(cost: sellLabelTextField.returnText())
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
