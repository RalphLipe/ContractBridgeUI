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
    var player: String? = nil
    var body: some View {
        VStack(alignment: .leading) {
            if let player = player {
                Text(player)
            }
            ForEach ([Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs], id: \.self) {
                suit in
                CardSetView(cards: hand, suit: suit).font(.system(size: 14, design: .monospaced))
            }
            // TODO:  This fixed font won't work...
        }
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        HandView(hand: [.aceOfSpades, .kingOfSpades, .queenOfHearts, .tenOfHearts, .fiveOfHearts, .sevenOfHearts, .fourOfDiamonds, .threeOfDiamonds, .nineOfClubs, .eightOfClubs, .sevenOfClubs, .sixOfClubs, .fiveOfClubs],
                 player: "Ralph Lipe")
    }
}
