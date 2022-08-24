//
//  CollectionCell.swift
//  ArtDeFond
//
//  Created by Ivan Vislov on 23.08.2022.
//

import Foundation
import UIKit

class CollectionCellSignUp: UICollectionViewCell {
    
    static let reuseIdentifier = "CollectionCellSignUp"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Fonts.semibold15
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 16
        view.layer.opacity = 0
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.removeFromSuperview()
        title.removeFromSuperview()
    }
    
    func configureCell(title: String, color: UIColor) {
        self.title.text = title
        self.backgroundColor = color
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
    }
    
    func createLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.addSubview(blackView)
        blackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalTo(blackView)
            make.left.equalTo(blackView.snp.left).inset(15)
            make.right.equalTo(blackView.snp.right).inset(15)
        }
    }
    
}
