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
import CoreData

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
    
    var page = 1
    let managedObjectContext: NSManagedObjectContext
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    let error = ErrorTracker()
    let parsedError = PublishSubject<Error>()
    
    init(_ managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        super.init()
        
        error.asObservable().bind(to: parsedError).disposed(by: rx.disposeBag)
    }
    
}
