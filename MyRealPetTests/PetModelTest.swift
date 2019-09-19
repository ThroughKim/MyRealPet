//
//  PetModelTest.swift
//  MyRealPetTests
//
//  Created by KimSeulWoo on 19/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import XCTest
@testable import MyRealPet

class PetModelTest: XCTestCase {
    let abby = Pet(type: .Cat, name: "Abby")
    let choco = Pet(type: .Dog, name: "Choco")
    let pero = Pet(type: .Parrot, name: "Pero")
    let leon = Pet(type: .Lizard, name: "Leon")
    
    func test_petModelProperties() {
        XCTAssertEqual(abby.name, "Abby")
        XCTAssertEqual(abby.type, Pet.Species.Cat)
        XCTAssertEqual(abby.sound, "야옹")
        
        XCTAssertEqual(choco.name, "Choco")
        XCTAssertEqual(choco.type, Pet.Species.Dog)
        XCTAssertEqual(choco.sound, "멍멍")
        
        XCTAssertEqual(pero.name, "Pero")
        XCTAssertEqual(pero.type, Pet.Species.Parrot)
        XCTAssertEqual(pero.sound, "안녕")
        
        XCTAssertEqual(leon.name, "Leon")
        XCTAssertEqual(leon.type, Pet.Species.Lizard)
        XCTAssertNil(leon.sound)
    }
    
}
