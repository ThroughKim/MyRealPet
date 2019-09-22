//
//  AddPetViewModel.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AddPetViewModel: ViewModel, ViewModelType {
    struct Input {
        let petType: Driver<Pet.Species>
        let petName: Driver<String>
        let saveTrigger: Driver<Void>
    }
    struct Output {
        let saved: Driver<Bool>
        let saveEnabled: Driver<Bool>
    }
    
    func transform(input: AddPetViewModel.Input) -> AddPetViewModel.Output {
        let petInfo = Driver.combineLatest(input.petType, input.petName)
        
        let saveEnabled = petInfo.map { type, name in
            return type != .Unknown && !name.isEmpty
        }
        
        let saved = BehaviorRelay<Bool>(value: false)
        
        input.saveTrigger.withLatestFrom(petInfo)
            .map { type, name -> Pet in
                let pet = Pet()
                pet.type = type
                pet.name = name
                return pet
            }
            .drive(onNext: { [weak self] pet in
                guard let self = self else { return }
                try! self.realm.write {
                    self.realm.add(pet)
                    saved.accept(true)
                }
            })
            .disposed(by: rx.disposeBag)
        
        return Output(
            saved: saved.asDriver(), saveEnabled: saveEnabled
        )
    }

}
