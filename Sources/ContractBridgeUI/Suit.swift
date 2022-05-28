//
//  Suit.swift
//  
//
//  Created by Ralph Lipe on 3/10/22.
//

import Foundation
import SwiftUI
import ContractBridge


public extension Suit {
    var color: SwiftUI.Color {
        switch self {
        case .clubs, .spades:    return .black
        case .hearts, .diamonds: return .red
        }
    }
}
