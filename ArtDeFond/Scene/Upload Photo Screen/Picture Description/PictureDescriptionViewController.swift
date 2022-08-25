//
//  PictureDescriptionViewController.swift
//  ArtDeFond
//
//  Created by developer on 23.08.2022.
//

import UIKit
import SnapKit
import TagListView

class PictureDescriptionViewController: UIViewController {
    
    private let materialLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withoutImage,
                                                                                        keyboardType: .default,
                                                                                        placeholder: "Холст и краски"),
                                                        labelText: "Материалы")
    private let yearLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withoutImage,
                                                                                    keyboardType: .numberPad,
                                                                                    placeholder: "2022"),
                                                    labelText: "Год")
    private let widthLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withoutImage,
                                                                                     keyboardType: .numberPad,
                                                                                     placeholder: "20 см"),
                                                     labelText: "Ширина")
    private let heightLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withoutImage,
                                                                                      keyboardType: .numberPad,
                                                                                      placeholder: "20 см"),
                                                      labelText: "Высота")
    
    private let tagList = TagListView()
    
    private let nextScreenButton = CustomButton(viewModel: .init(type: .dark, labelText: "Далее"))
    
    private let viewModel: PictureDescriptionViewModel
    
    init(viewModel: PictureDescriptionViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Описание картины"
        navigationItem.backButtonTitle = ""
        setup()
        bindToViewModel()
    }
    
    private func bindToViewModel(){
        viewModel.didGoToNextScreen = { [weak self] vc in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func setup(){
        materialLabelTextFieldSetup()
        yearLabelTextFieldSetup()
        widthLabelTextFieldSetup()
        heightLabelTextFieldSetup()
        nextScreenButtonSetup()
        tagListSetup()
    }
    
    private func materialLabelTextFieldSetup(){
        view.addSubview(materialLabelTextField)
        
        materialLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func yearLabelTextFieldSetup(){
        view.addSubview(yearLabelTextField)
        
        yearLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(materialLabelTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
    }
    
    private func widthLabelTextFieldSetup(){
        view.addSubview(widthLabelTextField)
        
        widthLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(yearLabelTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func heightLabelTextFieldSetup(){
        view.addSubview(heightLabelTextField)
        
        heightLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(widthLabelTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func nextScreenButtonSetup(){
        view.addSubview(nextScreenButton)
        
        nextScreenButton.addTarget(self, action: #selector(tapOnNextButton), for: .touchUpInside)
        
        nextScreenButton.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
    }
    
    private func tagListSetup(){
        view.addSubview(tagList)
        
        tagList.isUserInteractionEnabled = true
        tagList.delegate = self
        
        tagList.tagBackgroundColor = Constants.Colors.middleRed
        tagList.textColor = Constants.Colors.white
        tagList.borderColor = Constants.Colors.darkRed
        tagList.textFont = Constants.Fonts.semibold15
        tagList.borderWidth = 0
        tagList.alignment = .leading
        tagList.paddingX = 12
        tagList.paddingY = 8
        tagList.marginX = 10
        tagList.marginY = 10
        tagList.cornerRadius = 12
        
        tagList.addTag("Живопись")
        tagList.addTag("Гравюра")
        tagList.addTag("Абстракция")
        tagList.addTag("Портрет")
        tagList.addTag("Пейзаж")
        tagList.addTag("Рисунок")
        tagList.addTag("Авангард")
        tagList.addTag("Натюрморт")
        
        tagList.snp.makeConstraints{ make in
            make.top.equalTo(heightLabelTextField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
        }
//        tagListView.selectedTags().contains { $0.currentTitle == topic.title}

    }
    
    @objc
    private func tapOnNextButton(){
        viewModel.goToNextScreen(materials: materialLabelTextField.returnText(),
                                 year: yearLabelTextField.returnText(),
                                 width: widthLabelTextField.returnText(),
                                 height: heightLabelTextField.returnText(),
                                 tags: tagList.selectedTags())
    }

}

extension PictureDescriptionViewController: TagListViewDelegate{
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected = !tagView.isSelected
        
        if (tagView.isSelected){
            tagView.tagBackgroundColor = Constants.Colors.darkRed
        }
        else {
            tagView.tagBackgroundColor = Constants.Colors.middleRed
            
        }
    }
}
