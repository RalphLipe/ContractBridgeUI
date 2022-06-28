//
//  CardArrayView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/4/22.
//

import SwiftUI
import ContractBridge



public extension Suit {
    var isBlack: Bool {
        return self == .spades || self == .clubs
    }
}


public extension Set where Element == Card {
    var suits: Set<Suit> {
        var suits = Set<Suit>()
        forEach { suits.insert($0.suit) }
        return suits
    }
    
    func sortBlackRed(firstSuit: Suit? = nil) -> [Card] {
        var remainingSuits = suits
        var sortOrder: [Suit] = [.spades, .hearts, .clubs, .diamonds]
        var cards = Array(self)
        if suits.count == Suit.allCases.count {
            if let firstSuit = firstSuit, firstSuit != .spades {
                if firstSuit == .hearts {
                    sortOrder = [.hearts, .spades, .diamonds, .clubs]
                } else if firstSuit == .diamonds {
                    sortOrder = [.diamonds, .spades, .hearts, .clubs]
                } else {
                    assert(firstSuit == .clubs)
                    sortOrder = [.clubs, .hearts, .spades, .diamonds]
                }
            }
        }
        // TODO:  Work with just 1, 2 or 3 suits!...
        cards.sort { ($0.suit == $1.suit && $0.rank > $1.rank ) || sortOrder.firstIndex(of: $0.suit)! < sortOrder.firstIndex(of: $1.suit)!}
        return cards
    }
}


public enum CardSetViewOption {
    case images(horizontal: Bool = true), symbolBySuit, symbolOnly(suit: Suit? = nil)
}

public struct CardSetStaticView: View {
    @State private var cards: Set<Card>
    private let viewOption: CardSetViewOption
    
    public init(cards: Set<Card>, viewOption: CardSetViewOption = .images()) {
        self.cards = cards
        self.viewOption = viewOption
    }
    
    public var body: some View {
        CardSetView(cards: $cards, viewOption: viewOption)
    }
}

public struct CardSetView: View {
    @Binding var cards: Set<Card>
    var action: ((Card) -> Void)? = nil
    var viewOption: CardSetViewOption = .images()
    @Environment(\.cardScale) var cardScale: CGFloat
    
    public init(cards: Binding<Set<Card>>, action: ((Card) -> Void)? = nil, viewOption: CardSetViewOption = .images()) {
        self._cards = cards
        self.action = action
        self.viewOption = viewOption
    }

    private static let xOffset = 0.21
    private static let yOffset = 0.25
    
    public var body: some View {
        switch viewOption {
        case .images(let horizontal):
            let xOffset = horizontal ? Self.xOffset * Card.width * cardScale : 0.0
            let yOffset = horizontal ? 0.0 : Self.yOffset * Card.height * cardScale
            ZStack {
                let midpoint: CGFloat = CGFloat(cards.count - 1) / 2.0
                let sortedCards = cards.sortBlackRed()
                ForEach(0..<sortedCards.count, id: \.self) { index in
                    CardView(card: sortedCards[index], action: action).offset(x:  (midpoint - CGFloat(index)) * -xOffset, y: (midpoint - CGFloat(index)) * -yOffset)
                }
            }.frame(minWidth: Card.width * cardScale + (Double(cards.count - 1) * xOffset), minHeight: Card.height * cardScale + (Double(cards.count - 1) * yOffset)).animation(.easeInOut)

        case .symbolBySuit:
            VStack(alignment: .leading) {
                ForEach ([Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs], id: \.self) {
                    suit in
                    CardSetView(cards: $cards, viewOption: .symbolOnly(suit: suit)).font(.system(size: 14, design: .monospaced))
                }
            }
            
        case .symbolOnly(let suit):
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
        CardSetView(cards: $previewHand, viewOption: .images()).cardScale(0.15)
        CardSetView(cards: $previewHand, viewOption: .images(horizontal: false))
        CardSetView(cards: $previewHand, viewOption: .symbolBySuit)
        CardSetView(cards: $previewHand, viewOption: .symbolOnly(suit: nil))
        CardSetView(cards: $previewHand, viewOption: .symbolOnly(suit: .hearts))
        CardSetStaticView(cards: [.kingOfHearts, .queenOfSpades])
    }
}
