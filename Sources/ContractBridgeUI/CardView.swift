//
//  CardView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/4/22.
//

import SwiftUI
import ContractBridge

// TODO: Move to another file???
public extension Card {
    var image: Image {
        let imageName = "\(rank.shortDescription)\(suit, style: .character)"
        return Image(imageName, bundle: Bundle.module)
    }
}

public enum CardViewOption {
    case image, rankAndSuit, rank
}

public struct CardView: View {
    public var card: Card
    public var action: ((Card) -> Void)?
    public var viewOption: CardViewOption
    
    
    public init(card: Card, action: ((Card) -> Void)? = nil , viewOption: CardViewOption = .image) {
        self.card = card
        self.action = action
        self.viewOption = viewOption
    }
    
    public var body: some View {
        // TODO:  Need to make buttons or tap gestures for text cards...
        if viewOption == .rank {
            Text(card.rank.shortDescription)
        } else if viewOption == .rankAndSuit {
            HStack {
                let s = "\(card.suit)"
                Text(card.rank.shortDescription) +
                Text(s).foregroundColor(card.suit.color)
            }
        } else {
            if let action = action {
                card.image.resizable().scaledToFit().frame(width: 67.5, height: 105.0).gesture(TapGesture().onEnded { action(card) })
            } else {
                card.image.resizable().scaledToFit().frame(width: 67.5, height: 105.0)
            }
        }
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardView(card: Card(.ace, .spades))
            CardView(card: Card(.queen, .diamonds))
            CardView(card: .fourOfClubs)
        }
        
    }
}
