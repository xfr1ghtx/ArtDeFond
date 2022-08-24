//
//  UIImageView.swift
//  ArtDeFond
//
//  Created by Someone on 24.08.2022.
//

import Foundation
import UIKit

extension UIImageView{
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}
