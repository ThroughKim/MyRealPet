//
//  PetListViewModel.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class PetListViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let navigationTitle: Driver<String>
        let items: BehaviorRelay<[PetListCellViewModel]>
    }
    
    func transform(input: PetListViewModel.Input) -> PetListViewModel.Output {
        let title = Driver.just("펫 리스트")
        let items = BehaviorRelay<[PetListCellViewModel]>(value: [])
        
        _ = input.loadTrigger.drive(onNext: { [weak self] _ in
            guard let self = self else { return }
            let pets = self.realm.objects(Pet.self).sorted(byKeyPath: "created", ascending: false)
            Observable.collection(from: pets)
                .map { $0.elements }
                .map { $0.map { PetListCellViewModel(with: $0) } }
                .bind(to: items)
                .disposed(by: self.rx.disposeBag)
        })
        
        return Output(
            navigationTitle: title,
            items: items
        )
    }
    
}
