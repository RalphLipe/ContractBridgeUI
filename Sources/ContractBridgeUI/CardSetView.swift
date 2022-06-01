//
//  CardArrayView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/4/22.
//

import SwiftUI
import ContractBridge



public enum CardSetViewOption {
    case images, symbolBySuit, symbolOnly(suit: Suit? = nil)
}

struct CardSetStaticView: View {
    @State private var cards: Set<Card>
    private let viewOption: CardSetViewOption
    
    init(cards: Set<Card>, viewOption: CardSetViewOption = .images) {
        self.cards = cards
        self.viewOption = viewOption
    }
    
    var body: some View {
        CardSetView(cards: $cards, viewOption: viewOption)
    }
}

struct CardSetView: View {
    @Binding var cards: Set<Card>
    var action: ((Card) -> Void)? = nil
    var viewOption: CardSetViewOption = .images
    
    public init(cards: Binding<Set<Card>>, action: ((Card) -> Void)? = nil, viewOption: CardSetViewOption = .images) {
        self._cards = cards
        self.action = action
        self.viewOption = viewOption
    }

    private static let cardOffset = 12.0
    
    var body: some View {
        switch viewOption {
        case .images:
            ZStack {
                let midpoint: CGFloat = CGFloat(cards.count - 1) / 2.0
                let sortedCards = cards.sortedHandOrder()
                ForEach(0..<sortedCards.count, id: \.self) { index in
                    CardView(card: sortedCards[index], action: action).offset(x:  (midpoint - CGFloat(index)) * -Self.cardOffset, y: 0)
                }
            }.frame(minWidth: 67.5 + (Double(cards.count - 1) * Self.cardOffset)).animation(.easeInOut)

        case .symbolBySuit:
            VStack(alignment: .leading) {
                ForEach ([Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs], id: \.self) {
                    suit in
                    CardSetView(cards: $cards, viewOption: .symbolOnly(suit: suit)).font(.system(size: 14, design: .monospaced))
                }
            }
            
        case let .symbolOnly(suit):
            HStack {
                if let suit = suit {
                    let s = "\(suit, style: .symbol)"
                    Text(s).foregroundColor(suit.color)
                }
                let cardViewOption: CardViewOption = suit == nil ? .rankAndSuit : .rank
                ForEach (cards.sortedHandOrder(suit: suit), id: \.self) {
                    card in
                    CardView(card: card, action: action, viewOption: cardViewOption)
                }

            }
            
        }
    }
}



struct CardSet_Previews: PreviewProvider {
    @State static var previewHand: Set<Card> = [.aceOfSpades, .kingOfSpades, .queenOfHearts, .tenOfHearts, .fiveOfHearts, .sevenOfHearts, .fourOfDiamonds, .threeOfDiamonds, .nineOfClubs, .eightOfClubs, .sevenOfClubs, .sixOfClubs, .fiveOfClubs]
    static var previews: some View {
        CardSetView(cards: $previewHand, viewOption: .images)
        CardSetView(cards: $previewHand, viewOption: .symbolBySuit)
        CardSetView(cards: $previewHand, viewOption: .symbolOnly(suit: nil))
        CardSetView(cards: $previewHand, viewOption: .symbolOnly(suit: .hearts))
        CardSetStaticView(cards: [.kingOfHearts, .queenOfSpades])
    }
}
