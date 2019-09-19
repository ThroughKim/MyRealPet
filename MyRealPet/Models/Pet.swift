//
//  Pet.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 19/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

struct Pet {
    enum Species: Int {
        case Cat = 1, Dog, Parrot, Lizard
    }
    
    var type: Species
    var name: String
    var sound: String? {
        switch self.type {
        case .Cat: return "야옹"
        case .Dog: return "멍멍"
        case .Parrot: return "안녕"
        case .Lizard: return nil
        }
    }
    
}

extension Pet: Equatable {
    static func == (lhs: Pet, rhs: Pet) -> Bool {
        return lhs.name == rhs.name
    }
    
}

extension Pet: IdentifiableType {
    typealias Identity = String
    
    var identity: Identity { return name }
}

extension Pet: Persistable {
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "Pet"
    }
    
    static var primaryAttributeName: String {
        return "name"
    }
    
    init(entity: T) {
        let typeCode = entity.value(forKey: "type") as! Int
        guard let species = Pet.Species(rawValue: typeCode) else {
            fatalError("Invalid species code received")
        }
        type = species
        name = entity.value(forKey: "name") as! String
    }
    
    func update(_ entity: T) {
        entity.setValue(type, forKey: "type")
        entity.setValue(name, forKey: "name")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
        
    }
    
}
