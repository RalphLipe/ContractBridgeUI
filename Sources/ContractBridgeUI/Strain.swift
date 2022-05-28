//
//  Suit.swift
//  
//
//  Created by Ralph Lipe on 3/10/22.
//

import Foundation
import SwiftUI
import ContractBridge


public extension Strain {
    var color: SwiftUI.Color {
        switch self {
        case .noTrump: return .black
        default:       return Suit(rawValue: self.rawValue)!.color
        }
    }
}
