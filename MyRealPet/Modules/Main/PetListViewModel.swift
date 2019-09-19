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
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
    }
    
    struct Output {
        let navigationTitle: Driver<String>
        let items: BehaviorRelay<[String]>
    }
    
    func transform(input: PetListViewModel.Input) -> PetListViewModel.Output {
        let title = Driver.just("마이리얼펫")
        let items = BehaviorRelay<[String]>(value: [])
        
        input.headerRefresh.flatMapLatest({ [weak self] () -> Observable<[String]> in
            guard let self = self else { return Observable.just([]) }
            self.page = 1
            return self.request()
                .trackActivity(self.headerLoading)
        })
            .subscribe(onNext: { responseItems in
                items.accept(responseItems)
            }).disposed(by: rx.disposeBag)
        
        input.footerRefresh.flatMapLatest({ [weak self] () -> Observable<[String]> in
            guard let self = self else { return Observable.just([]) }
            self.page += 1
            return self.request()
                .trackActivity(self.footerLoading)
        })
            .subscribe(onNext: { responseItems in
                items.accept(items.value + responseItems)
            }).disposed(by: rx.disposeBag)
        
        return Output(
            navigationTitle: title,
            items: items
        )
    }

    func fetch() -> Observable<[String]> {
        return managedObjectContext.rx.entities(Pet.self)
            .map{$0.map{$0.name}}
        
    }
    
}
