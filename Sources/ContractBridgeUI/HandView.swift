//
//  HandView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/4/22.
//

import SwiftUI
import ContractBridge

struct HandView: View {
    var hand: Set<Card>
    var body: some View {
        VStack(alignment: .leading) {
            ForEach ([Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs], id: \.self) {
                suit in
                CardSetView(cards: hand, suit: suit)
            }
            // TODO:  This fixed font won't work...
        }.font(.system(size: 18, design: .monospaced))
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        HandView(hand: [.aceOfSpades, .kingOfSpades, .queenOfHearts, .tenOfHearts, .fiveOfHearts, .sevenOfHearts, .fourOfDiamonds, .threeOfDiamonds, .nineOfClubs, .eightOfClubs, .sevenOfClubs, .sixOfClubs, .fiveOfClubs])
    }
}
