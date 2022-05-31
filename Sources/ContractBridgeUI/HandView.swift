//
//  HandView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/4/22.
//

import SwiftUI
import ContractBridge


////////////
///

/*
public enum HandViewOption {
    case images, symbolBySuit
}

struct HandView: View {
    @Binding var hand: Set<Card>
    var player: String? = nil   // TODO:  Title?  Not player...
    var action: ((Card) -> Void)? = nil
    var viewOption: HandViewOption = .images
    
/*
    public init(hand: Binding<Set<Card>>, position: Position, action: @escaping (Card) -> Void = {_ in }) {
        self._cards = Binding(projectedValue: hand)
        self.action = action
    }
  */
    
    public func remove(card: Card)  {
        _ = self.hand.remove(card)
    }
    
    var body: some View {
        if viewOption == .images {
            ZStack {
                let midpoint: CGFloat = CGFloat(hand.count - 1) / 2.0
                let sortedCards = hand.sortedHandOrder()
                ForEach(0..<sortedCards.count, id: \.self) { index in
                    CardView(card: sortedCards[index], action: action).offset(x:  (midpoint - CGFloat(index)) * -16.0, y: 0)
                }
            }.frame(minWidth: 46.06 * 2.0 + (Double(hand.count - 1) * 16.0)).animation(.easeInOut)
        } else {
            VStack(alignment: .leading) {
                if let player = player {
                    Text(player)
                }
                ForEach ([Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs], id: \.self) {
                    suit in
                    CardSetView(cards: cards, suit: suit).font(.system(size: 14, design: .monospaced))
                }
            }
        }
    }
}






struct HandView_Previews: PreviewProvider {
    @State static var previewHand: Set<Card> = [.aceOfSpades, .kingOfSpades, .queenOfHearts, .tenOfHearts, .fiveOfHearts, .sevenOfHearts, .fourOfDiamonds, .threeOfDiamonds, .nineOfClubs, .eightOfClubs, .sevenOfClubs, .sixOfClubs, .fiveOfClubs]
    static var previews: some View {
        HandView(hand: $previewHand,
                 player: "Ralph Lipe", viewOption: .images
                 )
    }
}
*/
