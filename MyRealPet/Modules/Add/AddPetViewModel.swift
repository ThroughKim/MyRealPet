//
//  AddPetViewModel.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class AddPetViewModel: ViewModel, ViewModelType {
    struct Input {}
    struct Output {}
    
    func transform(input: AddPetViewModel.Input) -> AddPetViewModel.Output {
        return Output()
    }

}
