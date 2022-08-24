//
//  LabelSlider.swift
//  ArtDeFond
//
//  Created by developer on 24.08.2022.
//

import Foundation
import UIKit

final class LabelSwitch: UIView{
    
    private let stackView = UIStackView()
    private let label = UILabel()
    public let uiswitch = UISwitch()
    
    init(frame: CGRect = CGRect.zero, text: String){
        label.text = text
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
        addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .lastBaseline
        
        stackView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        label.font = Constants.Fonts.regular17
        stackView.addArrangedSubview(label)
        
        stackView.addArrangedSubview(uiswitch)
        uiswitch.onTintColor = Constants.Colors.darkRed
    }
    
}
