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
import NSObject_Rx
import SnapKit

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
        
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = .lightGray
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }

}

