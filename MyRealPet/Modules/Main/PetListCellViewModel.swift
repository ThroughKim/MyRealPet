//
//  PetListCellViewModel.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PetListCellViewModel: NSObject {
    let pet: Pet
    
    let petSelected = PublishSubject<Pet>()
    
    let type = BehaviorRelay<String?>(value: nil)
    let name = BehaviorRelay<String?>(value: nil)
    
    init(with pet: Pet) {
        self.pet = pet
        self.type.accept(pet.type.getEmoji())
        self.name.accept(pet.name)
    }
    
}
