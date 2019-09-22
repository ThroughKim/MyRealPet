//
//  AddPetViewController.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 22/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddPetViewController: ViewController {
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "생성", style: .done, target: self, action: nil)
        button.isEnabled = false
        return button
    }()
    
    lazy var typeField: UITextField = {
        let field = UITextField()
        field.snp.makeConstraints{ make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        field.backgroundColor = .lightGray
        field.placeholder = "종류를 선택하세요"
        return field
    }()
    lazy var nameField: UITextField = {
        let field = UITextField()
        field.snp.makeConstraints{ make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        field.backgroundColor = .lightGray
        field.placeholder = "이름을 입력하세요"
        return field
    }()
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [self.typeField, self.nameField])
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    lazy var typePicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let petTypes: [Pet.Species] = [.Cat, .Dog, .Lizard, .Parrot]
    
    override func setupUI() {
        super.setupUI()
        navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(40)
            make.centerX.equalToSuperview()
        }
        typeField.inputView = typePicker
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        Observable.just(petTypes)
            .bind(to: typePicker.rx.itemTitles) { _, item in return "\(item.getString())"}
            .disposed(by: rx.disposeBag)
        
        typePicker.rx.modelSelected(Pet.Species.self)
            .map{ $0[0].getString() }
            .bind(to: typeField.rx.text)
            .disposed(by: rx.disposeBag)
        
        guard let viewModel = viewModel as? AddPetViewModel else { return }
        
        let selectedType = typePicker.rx.modelSelected(Pet.Species.self)
            .map { $0[0] }
            .asDriver(onErrorJustReturn: .Unknown)
        
        let input = AddPetViewModel.Input(
            petType: selectedType,
            petName: nameField.rx.text.orEmpty.asDriver(),
            saveTrigger: saveButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input: input)
        
        output.saveEnabled.drive(saveButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        output.saved.filter { $0 }
            .drive(onNext: { [weak self] saved in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: rx.disposeBag)
    }
    
}
