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
    CollectionModelSearch(title: "Живопись", imageView: UIImage(named: "1")!),
    CollectionModelSearch(title: "Гравюра", imageView: UIImage(named: "2")!),
    CollectionModelSearch(title: "Живопись", imageView: UIImage(named: "3")!),
    CollectionModelSearch(title: "Гравюра", imageView: UIImage(named: "4")!),
    CollectionModelSearch(title: "Живопись", imageView: UIImage(named: "5")!),
    CollectionModelSearch(title: "Гравюра", imageView: UIImage(named: "6")!),
    CollectionModelSearch(title: "Живопись", imageView: UIImage(named: "7")!),
    CollectionModelSearch(title: "Гравюра", imageView: UIImage(named: "8")!),
]
