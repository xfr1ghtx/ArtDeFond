//
//  LabelTextField.swift
//  ArtDeFond
//
//  Created by developer on 18.08.2022.
//

import Foundation
import UIKit
import SnapKit

final class LabelTextField: UIView {
    private let textField: CustomTextField
    private let label = UILabel()
    
    init(frame: CGRect = CGRect.zero, CustomTextFieldViewModel: CustomTextFieldViewModel, labelText: String){
        textField = CustomTextField(viewModel: CustomTextFieldViewModel)
        label.text = labelText
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup(){
        labelSetup()
        textFieldSetup()
        
    }
    
    private func labelSetup(){
        addSubview(label)
        
        label.font = Constants.Fonts.regular15
        label.textColor = Constants.Colors.brown
        
        label.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview()
        }
    }
    
    private func textFieldSetup(){
        addSubview(textField)
        
        textField.snp.makeConstraints{ make in
            make.top.equalTo(label.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(42)
            make.bottom.equalToSuperview()
        }
    }
    
   
    
    
}
