//
//  UIColor Extensions.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 20/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

import UIKit

extension UIColor {
    
    static let primary = UIColor(hex: 0x3398ea)
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(r:(hex >> 16) & 0xff, g:(hex >> 8) & 0xff, b:hex & 0xff)
    }
    
}
