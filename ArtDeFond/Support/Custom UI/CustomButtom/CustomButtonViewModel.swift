//
//  CustomButtonViewModel.swift
//  ArtDeFond
//
//  Created by developer on 19.08.2022.
//

import Foundation
import UIKit

struct CustomButtonViewModel{
    let type: CustomButtomType
    let labelText: String
    
    init(type: CustomButtomType, labelText: String){
        self.type = type
        self.labelText = labelText
    }
}
