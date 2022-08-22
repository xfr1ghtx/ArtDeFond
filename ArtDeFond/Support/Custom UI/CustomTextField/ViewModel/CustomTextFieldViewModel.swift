//
//  CustomTextFieldViewModel.swift
//  ArtDeFond
//
//  Created by developer on 15.08.2022.
//

import Foundation
import UIKit

struct CustomTextFieldViewModel{
    
    let type: CustomTextFieldType
    let keyboardType: UIKeyboardType
    let placeholder: String
    let image: UIImage?
    
    init(type: CustomTextFieldType, keyboardType: UIKeyboardType, placeholder: String = "", image: UIImage? = nil){
        self.type = type
        self.keyboardType = keyboardType
        self.placeholder = placeholder
        self.image = image
    }
}




