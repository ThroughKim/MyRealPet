//
//  NavigationController.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        navigationBar.barTintColor = .primary
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.preferredFont(forTextStyle: .title2)
        ]
        
    }
    
}
