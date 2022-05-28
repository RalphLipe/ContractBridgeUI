//
//  CardArrayView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/4/22.
//

import SwiftUI
import ContractBridge

struct CardSetView: View {
    @State var cards: [Card]
    var suit: Suit? = nil
    
    init(cards: Set<Card>, suit: Suit? = nil) {
        self.suit = suit
        var cardArray = Array(suit == nil ? cards : cards.filter { $0.suit == suit })
        cardArray.sortHandOrder()
        self.cards = cardArray
    }
    
    var body: some View {
        HStack {
            if let suit = suit {
                let s = "\(suit)"
                Text(s).foregroundColor(suit.color)
            }
            ForEach(cards, id: \.self) { card in
                CardView(card: card, rankOnly: (suit != nil))
            }
        }
    }
}


struct CardCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CardSetView(cards: [
            Card(.ten, .clubs),
            Card(.two, .diamonds),
            Card(.ace, .spades)])
    }
}
