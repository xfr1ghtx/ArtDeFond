//
//  PictureDetailViewController.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import UIKit

class PictureDetailViewController: UIViewController {
    
    private var viewModel: PictureDetailViewModel!

    let headerHeight: CGFloat = 250 // 210

    private var headerTopConstraint: NSLayoutConstraint!
    private var headerHeightConstraint: NSLayoutConstraint!
    
    
    lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Constants.Colors.dirtyWhite
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // VIEWS
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = UIColor(named: "greyMain")
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "greyMain")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        
        label.text = "ЖИВОПИСЬ АБСТРАКЦИЯ"
        label.textColor = Constants.Colors.gray
        label.font = Constants.Fonts.semibold11
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Красивое название картины"
        label.numberOfLines = 0
        label.textColor = Constants.Colors.darkRed
        label.font = Constants.Fonts.semibold20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Прекрасное описание нашей картины с красивым назнанием. Сюжет данного шедевра останется неразгаданной загадкой. Это все, что об этом можно сказать."
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var materialTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Материалы"
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var materialLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Холст, масло"
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var sizeTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Размеры"
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sizeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "1cm x 2cm"
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Год"
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        
        label.text = "2001"
        label.textColor = Constants.Colors.pink
        label.font = Constants.Fonts.regular15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var authorImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = Constants.Colors.pink
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "pic")
        imageView.sizeToFit()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        
        label.text = "SOMEONE"
        label.numberOfLines = 1
        label.font = Constants.Fonts.semibold11
        label.textColor = Constants.Colors.gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startBetLabel: UILabel = {
        let label = UILabel()
        
        label.text = "$ 000,00"
        label.numberOfLines = 1
        label.font = Constants.Fonts.medium15
        label.textColor = Constants.Colors.gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var startBetTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Начальная ставка"
        label.numberOfLines = 1
        label.font = Constants.Fonts.medium15
        label.textColor = Constants.Colors.gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currentAmountTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Текущая ставка"
        label.numberOfLines = 1
        label.font = Constants.Fonts.medium17
        label.textColor = Constants.Colors.darkRed
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currentAmountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "$ 000,00"
        label.numberOfLines = 1
        label.font = Constants.Fonts.medium17
        label.textColor = Constants.Colors.darkRed
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    lazy var scaleImageBtn: UIButton = {
        let button = UIButton()
        button.tintColor = Constants.Colors.darkRed
        let config = UIImage.SymbolConfiguration(
            pointSize: 24, weight: .bold, scale: .medium)
        let image = UIImage(systemName: "square.dashed", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.5)
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(scaleBtnPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func scaleBtnPressed(){
        print("scaleBtnPressed")
    }
    
    lazy var arBtn: UIButton = {
        let button = UIButton()
        button.tintColor = Constants.Colors.darkRed
        let config = UIImage.SymbolConfiguration(
            pointSize: 24, weight: .bold, scale: .medium)
        let image = UIImage(systemName: "arkit", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.5)
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(arBtnPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func arBtnPressed(){
        print("arBtnPressed")
    }

    
    
    lazy var backBtn: UIButton = {
        let button = UIButton()
        button.tintColor = Constants.Colors.darkRed

        let image = UIImage(named: "cross")
        button.setImage(image, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.5)
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func backBtnPressed(){
        print("backBtnPressed")
    }

    lazy var editImageBtn: UIButton = {
        let button = UIButton()
        button.tintColor = Constants.Colors.darkRed
        let config = UIImage.SymbolConfiguration(
            pointSize: 24, weight: .bold, scale: .medium)
        let image = UIImage(systemName: "play.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.5)
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(editBtnPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func editBtnPressed(){
        print("editBtnPressed")
    }
    
    
    


    private func makeLine() -> UIView {
        let view = UIView()
        view.backgroundColor = Constants.Colors.pink
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    
    private func makeStackView(l1: UILabel, l2:UILabel) -> UIStackView{
        let sv = UIStackView(arrangedSubviews: [l1, l2])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.distribution = .equalSpacing
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }
    
    
    init(viewModel: PictureDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchPicture {
            self.configurePictureInfo()
        }
        layout()
        
//        
//        let image = UIImageView()
//        image.image = UIImage(named: "logo")
        
//        if let imageToUpload = image.image {
////            ImageManager.shared.upload(image: imageToUpload) { result in
////                switch result {
////                case .failure(let error):
////                    print(error)
////                case .success(let something):
////                    print(something)
////                }
////            }
//        } else {
//            print("some shit")
//        }
        
        
    }
    
    func configurePictureInfo(){
        // image
        // ar???
        
        
        
        guard let picture = viewModel.picture else {
            return
        }
        
        ImageManager.shared.image(with: picture.image) { [weak self] result in
            switch result {
            case .success(let image):
                self?.pictureImageView.image = image
            case .failure:
                self?.pictureImageView.image = nil
            }
        }
        
        var categoriesString = ""
        picture.tags.forEach({ tag in
            categoriesString = categoriesString + tag + " "
        })
        categoriesLabel.text = categoriesString.uppercased()
        
        titleLabel.text = picture.title
        descriptionLabel.text = picture.description
        materialLabel.text = picture.materials
        
        let sizeString = "\(picture.width)см x \(picture.height)см"
        sizeLabel.text = sizeString
        
        yearLabel.text = "\(picture.year)"
        
        // author configuration
        
        // bet configuration
    }
    
    
    private func layout() {
        mainContainerView.addSubview(pictureImageView)
        scrollView.addSubview(mainContainerView)
        view.addSubview(scrollView)

        let whiteView = UIView()

        whiteView.backgroundColor = .white
        scrollView.addSubview(whiteView)
        
        view.backgroundColor = UIColor(named: "mainGrey")
        scrollView.backgroundColor = .white
        
        // rewrite with snapkit !!!
        NSLayoutConstraint.activate([
            scrollView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor)
        ])
        
        
        headerTopConstraint = mainContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        headerHeightConstraint = mainContainerView.heightAnchor
            .constraint(equalToConstant: 250) //210
        
        NSLayoutConstraint.activate([
            headerTopConstraint,
            mainContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            headerHeightConstraint
        ])
        
        
        
        pictureImageView.snp.makeConstraints { make in
            make.top.equalTo(mainContainerView.snp.top)
            make.leading.equalTo(mainContainerView.snp.leading)
            make.trailing.equalTo(mainContainerView.snp.trailing)
            make.bottom.equalTo(mainContainerView.snp.bottom)
        }
        
//        scrollView.addSubview(editImageBtn)
//        editImageBtn.snp.makeConstraints { make in
//            make.top.equalTo(pictureImageView.snp.top).offset(18)
//            make.trailing.equalToSuperview().inset(16)
//            make.width.equalTo(42)
//            make.height.equalTo(42)
//        }
        
        scrollView.addSubview(arBtn)
        arBtn.snp.makeConstraints { make in
            make.top.equalTo(pictureImageView.snp.top).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(42)
            make.height.equalTo(42)
        }
        

        scrollView.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(pictureImageView.snp.top).offset(16)
            make.leading.equalTo(scrollView.snp.leading).offset(16)
            make.width.equalTo(42)
            make.height.equalTo(42)
        }
        
        
        
        whiteView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(240)// 200
            make.width.equalTo(view.snp.width)
        }
        
        
        whiteView.addSubview(categoriesLabel)
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
        }
        
        whiteView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoriesLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
        }
        
        whiteView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
        }
        
        let firstLine = makeLine()
        whiteView.addSubview(firstLine)
        firstLine.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
//            make.bottom.equalToSuperview()
        }
        
        let materialsStackView = makeStackView(l1: materialTitleLabel, l2: materialLabel)
        whiteView.addSubview(materialsStackView)
        materialsStackView.snp.makeConstraints { make in
            make.top.equalTo(firstLine.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
        }
        
        let sizeStackView = makeStackView(l1: sizeTitleLabel, l2: sizeLabel)
        whiteView.addSubview(sizeStackView)
        sizeStackView.snp.makeConstraints { make in
            make.top.equalTo(materialsStackView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
        }
        
        let yearStackView = makeStackView(l1: yearTitleLabel, l2: yearLabel)
        whiteView.addSubview(yearStackView)
        yearStackView.snp.makeConstraints { make in
            make.top.equalTo(sizeStackView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
        }
        
        let secondLine = makeLine()
        whiteView.addSubview(secondLine)
        secondLine.snp.makeConstraints { make in
            make.top.equalTo(yearStackView.snp.bottom).offset(19)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
        }
        
        whiteView.addSubview(authorImageView)
        authorImageView.snp.makeConstraints { make in
            make.height.width.equalTo(36)
            make.leading.equalToSuperview().offset(27)
            make.top.equalTo(secondLine.snp.bottom).offset(19)
        }
        
        whiteView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.leading.equalTo(authorImageView.snp.trailing).offset(13)
            make.trailing.equalToSuperview().inset(27)
            make.centerY.equalTo(authorImageView.snp.centerY)
            
        }
        
        let thirdLine = makeLine()
        whiteView.addSubview(thirdLine)
        thirdLine.snp.makeConstraints { make in
            make.top.equalTo(authorImageView.snp.bottom).offset(19)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
            
        }
        
        let currentBetStackView = makeStackView(l1: currentAmountTitleLabel, l2: currentAmountLabel)
        whiteView.addSubview(currentBetStackView)
        currentBetStackView.snp.makeConstraints { make in
            make.top.equalTo(thirdLine.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
        }
        
        let startBetStackView = makeStackView(l1: startBetTitleLabel, l2: startBetLabel)
        whiteView.addSubview(startBetStackView)
        startBetStackView.snp.makeConstraints { make in
            make.top.equalTo(currentBetStackView.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
            make.bottom.equalToSuperview() // !!!!
        }
    }
}


extension PictureDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView.contentOffset.y < 0.0 {
                // Scrolling down: Scale
                headerHeightConstraint?.constant =
                    headerHeight - scrollView.contentOffset.y
                
                if (scrollView.contentOffset.y < -210){
                    print("playTrailerBtnPressed()")
                }
            } else {
                // Scrolling up: Parallax
                let parallaxFactor: CGFloat = 0.25
                let offsetY = scrollView.contentOffset.y * parallaxFactor
                let minOffsetY: CGFloat = 8.0
                let availableOffset = min(offsetY, minOffsetY)
                let contentRectOffsetY = availableOffset / headerHeight
                headerTopConstraint?.constant = view.frame.origin.y
                headerHeightConstraint?.constant =
                    headerHeight - scrollView.contentOffset.y
                pictureImageView.layer.contentsRect =
                    CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
                
                UIView.animate(withDuration: 0.1) {
                    self.pictureImageView.alpha = (self.headerHeight - 150 - offsetY) / (self.headerHeight - 150)
                }
                
            }
        let offset = abs(scrollView.contentOffset.y)
        UIView.animate(withDuration: 0.1) {
            self.arBtn.alpha = (self.headerHeight - 140 - offset) / (self.headerHeight - 140)
            self.scaleImageBtn.alpha = (self.headerHeight - 140 - offset) / (self.headerHeight - 140)
            self.backBtn.alpha = (self.headerHeight - 140 - offset) / (self.headerHeight - 140)
        }
    }
}

