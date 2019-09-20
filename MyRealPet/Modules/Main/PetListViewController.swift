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

class PetListViewController: ViewController, UIScrollViewDelegate {
    
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = .lightGray
        
        error.subscribe(onNext: { error in
            print(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? PetListViewModel else { return }
        
        let input = PetListViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.navigationTitle.drive(onNext: { [weak self] title in
            self?.navigationTitle = title
        }).disposed(by: rx.disposeBag)
        
        output.items.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { tableView, viewModel, cell in
                cell.textLabel?.text = viewModel
            }.disposed(by: rx.disposeBag)
        
    }

}

