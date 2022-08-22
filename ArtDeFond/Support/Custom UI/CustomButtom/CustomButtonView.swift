//
//  CustomButtonView.swift
//  ArtDeFond
//
//  Created by developer on 19.08.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    private var viewModel: CustomButtonViewModel
    
    init(frame: CGRect = CGRect.zero, viewModel: CustomButtonViewModel){
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup(){
        layer.cornerRadius = 16
        setTitle(viewModel.labelText, for: .normal)
        titleLabel?.font = Constants.Fonts.medium17
        switch viewModel.type{
            
        case .light:
            backgroundColor = Constants.Colors.dirtyWhite
            setTitleColor(Constants.Colors.darkRed, for: .normal)
        case .dark:
            backgroundColor = Constants.Colors.darkRed
            setTitleColor(Constants.Colors.dirtyWhite, for: .normal)
        }
    }
                   
                   
    
}
