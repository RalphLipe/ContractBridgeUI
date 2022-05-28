//
//  CardView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/4/22.
//

import SwiftUI
import ContractBridge


struct CardView: View {
    var card: Card
    var rankOnly = false
    
    var body: some View {
        if rankOnly {
            Text(card.rank.shortDescription)
        } else {
            HStack {
                let s = "\(card.suit)"
                Text(card.rank.shortDescription) +
                Text(s).foregroundColor(card.suit.color)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardView(card: Card(.ace, .spades))
            CardView(card: Card(.queen, .diamonds))
        }
        
    }
}
