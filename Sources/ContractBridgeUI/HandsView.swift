//
//  HandsView.swift
//
//  Created by Ralph Lipe on 2/13/22.
//

import SwiftUI
import ContractBridge

struct HandsView: View {
    @Binding var hands: Hands
    var players: [Position: String] = [:]
    var showPoints: Bool = false
    var viewOption: CardSetViewOption = .symbolBySuit

    var body: some View {
        VStack {
            CardSetView(cards: $hands[.north],  viewOption: viewOption)
            HStack {
                CardSetView(cards: $hands[.west],  viewOption: viewOption)
                Spacer()
                if showPoints {
                    VStack {
                        Text("\(hands[.north].highCardPoints)")
                        HStack {
                            Text("\(hands[.west].highCardPoints)")
                            Spacer()
                            Text("\(hands[.east].highCardPoints)")
                        }.padding()
                        Text("\(hands[.south].highCardPoints)")
                    }.border(.gray).padding()
                    Spacer()
                }
                CardSetView(cards: $hands[.east], viewOption: viewOption)
            }.padding()
            CardSetView(cards: $hands[.south], viewOption: viewOption)
        }
    }
}

struct HandsView_Previews: PreviewProvider {
    @State static var previewDeal = try! Deal(from: "S:A83.AT.AQT74.T72 Q74.KQ6.J9863.J4 J92.J742.K5.K965 KT65.9853.2.AQ83")
    static var previews: some View {
        HandsView(hands: $previewDeal.hands, showPoints: true)
        HandsView(hands: $previewDeal.hands,
                 players: [.north: "Ralph", .east: "Holdon", .south: "Lynda", .west: "Marc"],
                showPoints: false,
                 viewOption: .images())
    }
}
