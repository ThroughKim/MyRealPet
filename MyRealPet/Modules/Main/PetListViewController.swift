//
//  PetListViewController.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 19/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController

class PetListViewController: ViewController, UIScrollViewDelegate {
    
    lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(), style: .plain)
        view.rx.setDelegate(self).disposed(by: rx.disposeBag)
        self.view.addSubview(view)
        view.snp.makeConstraints{ make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = addButton
        tableView.register(PetListCell.self, forCellReuseIdentifier: "cell")
    }

    override func setupUI() {
        super.setupUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? PetListViewModel else { return }
        
        let viewWillAppear = rx.viewWillAppear
            .map{ _ in }
            .asDriver(onErrorJustReturn: ())
        
        let input = PetListViewModel.Input(
            loadTrigger: viewWillAppear
        )
        let output = viewModel.transform(input: input)
        
        output.navigationTitle.drive(onNext: { [weak self] title in
            self?.navigationTitle = title
        }).disposed(by: rx.disposeBag)
        
        output.items.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "cell", cellType: PetListCell.self)) { tableView, viewModel, cell in
                cell.bind(to: viewModel)
            }.disposed(by: rx.disposeBag)
        
        error.subscribe(onNext: { [weak self] error in
                self?.showAlert(title: "오류", body: error.localizedDescription)
            }).disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(PetListCellViewModel.self)
            .map { $0.pet.sound }
            .filterNil()
            .subscribe(onNext: { [weak self] sound in
                self?.showAlert(title: sound, body: "")
            }).disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected
            .map{ (at: $0, animated: true) }
            .subscribe(onNext: tableView.deselectRow)
            .disposed(by: rx.disposeBag)
        
        addButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                let addPetViewModel = AddPetViewModel()
                self?.navigationController?.pushViewController(AddPetViewController(viewModel: addPetViewModel), animated: true)
            }).disposed(by: rx.disposeBag)
        
    }

}

