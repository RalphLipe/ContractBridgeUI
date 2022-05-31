//
//  CardViewTest.swift
//  
//
//  Created by Ralph Lipe on 5/29/22.
//

import XCTest
import ContractBridge
import ContractBridgeUI

class CardViewTest: XCTestCase {



    func testCardImage() throws {
        let card = Card.aceOfSpades
        let image = card.image
        XCTAssertNotNil(image)
    }



}
