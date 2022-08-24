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

class CollectionModelSearch {
    var title: String
    var imageView: UIImage
    
    init(title: String, imageView: UIImage) {
        self.title = title
        self.imageView = imageView
    }}

let modelArraySearch: [CollectionModelSearch] = [
    CollectionModelSearch(title: "Живопись", imageView: Constants.Images.logo),
    CollectionModelSearch(title: "Гравюра", imageView: Constants.Images.logo),
    CollectionModelSearch(title: "Живопись", imageView: Constants.Images.logo),
    CollectionModelSearch(title: "Гравюра", imageView: Constants.Images.logo),
    CollectionModelSearch(title: "Живопись", imageView: Constants.Images.logo),
    CollectionModelSearch(title: "Гравюра", imageView: Constants.Images.logo),
    CollectionModelSearch(title: "Живопись", imageView: Constants.Images.logo),
    CollectionModelSearch(title: "Гравюра", imageView: Constants.Images.logo),
]
