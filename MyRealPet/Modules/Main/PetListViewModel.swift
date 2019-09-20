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
    }
    
    struct Output {
        let navigationTitle: Driver<String>
        let items: BehaviorRelay<[String]>
    }
    
    func transform(input: PetListViewModel.Input) -> PetListViewModel.Output {
        let title = Driver.just("마이리얼펫")
        let items = BehaviorRelay<[String]>(value: [])
        
        let pets = realm.objects(Pet.self)
        Observable.collection(from: pets)
            .map { result in result.elements.map{ $0.name } }
            .bind(to: items)
            .disposed(by: rx.disposeBag)
        
        return Output(
            navigationTitle: title,
            items: items
        )
    }
    
}
