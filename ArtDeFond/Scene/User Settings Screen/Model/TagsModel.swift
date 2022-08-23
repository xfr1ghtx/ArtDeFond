//
//  TagsModel.swift
//  ArtDeFond
//
//  Created by Ivan Vislov on 23.08.2022.
//

import Foundation
import UIKit

class CollectionModel {
    var title: String
    var color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
}

let modelArray: [CollectionModel] = [
    CollectionModel(title: "Живопись", color: Constants.Colors.pink),
    CollectionModel(title: "Гравюра", color: Constants.Colors.pink),
    CollectionModel(title: "Живопись", color: Constants.Colors.pink),
    CollectionModel(title: "Гравюра", color: Constants.Colors.pink),
    CollectionModel(title: "Живопись", color: Constants.Colors.pink),
    CollectionModel(title: "Гравюра", color: Constants.Colors.pink),
    CollectionModel(title: "Живопись", color: Constants.Colors.pink),
    CollectionModel(title: "Гравюра", color: Constants.Colors.pink),
]
