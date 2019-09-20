//
//  ViewModel.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
    
    let realm: Realm
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    let error = ErrorTracker()
    let parsedError = PublishSubject<Error>()
    
    override init() {
        self.realm = try! Realm()
        super.init()
        
        error.asObservable().bind(to: parsedError).disposed(by: rx.disposeBag)
    }
    
}
