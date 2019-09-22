//
//  LibrariesManager.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import NSObject_Rx
import RxOptional
import RealmSwift
import RxRealm

class LibrariesManager: NSObject {
    
    static let shared = LibrariesManager()
    
    func setupLibs() {
        let librariesManager = LibrariesManager.shared
        librariesManager.setupRealm()
    }
    
    func setupRealm() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
}

