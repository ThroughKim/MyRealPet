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
import KafkaRefresh

class LibrariesManager: NSObject {
    
    static let shared = LibrariesManager()
    
    func setupLibs() {
        let librariesManager = LibrariesManager.shared
        librariesManager.setupKafkaRefresh()
    }
    
    private func setupKafkaRefresh() {
        if let defaults = KafkaRefreshDefaults.standard() {
            defaults.headDefaultStyle = .replicatorCircle
            defaults.footDefaultStyle = .replicatorCircle
            defaults.themeColor = .primary
        }
    }
    
}

