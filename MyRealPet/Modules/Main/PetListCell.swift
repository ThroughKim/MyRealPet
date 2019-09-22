//
//  PetListCell.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PetListCell: UITableViewCell {
    
    lazy var typeLabel: UILabel = {
        return UILabel()
    }()
    lazy var nameLabel: UILabel = {
        return UILabel()
    }()
    lazy var spacer: UIView = {
        let view = UIView()
        view.setPriority(.defaultLow, for: .horizontal)
        return view
    }()
    lazy var stackView: UIStackView = {
        let views = [self.typeLabel, self.nameLabel, self.spacer]
        let view = UIStackView(arrangedSubviews: views)
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        layer.masksToBounds = true
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    func bind(to viewModel: PetListCellViewModel) {
        viewModel.type.asDriver().drive(typeLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.name.asDriver().drive(nameLabel.rx.text).disposed(by: rx.disposeBag)
    }

}
