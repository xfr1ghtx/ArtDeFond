//
//  TestViewController.swift
//  ArtDeFond
//
//  Created by developer on 15.08.2022.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Some title"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.darkRed]

       
        
//        for index in 1...10 {
//            PicturesManager.shared.newPicture(id: "\(index)", title: "Picture num - \(index)", image: "", description: "Some cool description", year: 2001, materials: "materials", width: 12, height: 12, price: 12, isAuction: false, auction: nil, tags: [], time: Date.distantPast) { result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let something):
//                    print(something)
//                }
//            }
//        }
        
    }
}
