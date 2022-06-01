//
//  TrickView.swift
//
//  Created by Ralph Lipe on 3/16/22.
//

import SwiftUI
import ContractBridge


struct PlayPositionView: View {
    let card: Card?
    let edge: Edge
        
    var body: some View {
        if let card = self.card {
            CardView(card: card).transition(.move(edge: edge))
        } else {
            Text("").frame(width: 67.5, height: 105.0)
        }
    }
}

struct TrickView: View {
    @Binding var trick: Trick?
    
    private func playPosition(_ position: Position, edge: Edge) -> some View {
        var card: Card? = nil
        if let trick = self.trick { card = trick.cards[position] }
        return PlayPositionView(card: card, edge: edge)
    }
    
    var body: some View {
        withAnimation(.easeIn) {
            HStack {
                playPosition(.west, edge: .leading)
                VStack {
                    Spacer()
                    playPosition(.north, edge: .top)
                    Spacer()
                    playPosition(.south, edge: .bottom)
                    Spacer()
                }
                playPosition(.east, edge: .trailing)
            }.animation(.easeInOut)
        }
    }
}

struct TrickView_Previews: PreviewProvider {
    @State static var trick: Trick? = Trick(lead: Card(.king, .diamonds), position: .north, strain: .hearts)
    
    
    static var previews: some View {
        Group {
            TrickView(trick: $trick)
            TrickView(trick: $trick)
            TrickView(trick: $trick)
        }
    }
}
