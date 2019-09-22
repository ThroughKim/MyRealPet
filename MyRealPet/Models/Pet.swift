//
//  Pet.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 19/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import RealmSwift

class Pet: Object {
    enum Species: Int, CaseIterable {
        case Unknown = 0, Cat, Dog, Parrot, Lizard
        
        func getEmoji() -> String {
            switch self {
            case .Cat: return "🐱"
            case .Dog: return "🐶"
            case .Parrot: return "🦜"
            case .Lizard: return "🦎"
            case .Unknown: return "👾"
            }
        }
        func getString() -> String {
            switch self {
            case .Cat: return "고양이"
            case .Dog: return "강아지"
            case .Parrot: return "앵무새"
            case .Lizard: return "도마뱀"
            case .Unknown: return "???"
            }
        }
    }
    
    @objc dynamic var id = UUID().uuidString
    @objc private dynamic var speciesCode: Int = 0
    @objc dynamic var name: String = "이름없음"
    
    var type: Species {
        get { return Species(rawValue: speciesCode) ?? .Unknown }
        set { speciesCode = newValue.rawValue }
    }
    
    var sound: String? {
        switch self.type {
        case .Cat: return "야옹"
        case .Dog: return "멍멍"
        case .Parrot: return "안녕"
        default: return nil
        }
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
