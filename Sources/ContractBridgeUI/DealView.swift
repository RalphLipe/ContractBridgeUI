//
//  DealView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/13/22.
//

import SwiftUI
import ContractBridge

struct DealView: View {
    @Binding var deal: Deal
    var players: [Position: String] = [:]
    var showPoints: Bool = false
    var viewOption: CardSetViewOption = .symbolBySuit

    var body: some View {
        VStack {
            CardSetView(cards: $deal[.north],  viewOption: viewOption)
            HStack {
                CardSetView(cards: $deal[.west],  viewOption: viewOption)
                Spacer()
                if showPoints {
                    VStack {
                        Text("\(deal[.north].highCardPoints)")
                        HStack {
                            Text("\(deal[.west].highCardPoints)")
                            Spacer()
                            Text("\(deal[.east].highCardPoints)")
                        }.padding()
                        Text("\(deal[.south].highCardPoints)")
                    }.border(.gray).padding()
                    Spacer()
                }
                CardSetView(cards: $deal[.east], viewOption: viewOption)
            }.padding()
            CardSetView(cards: $deal[.south], viewOption: viewOption)
        }
    }
}

struct DealView_Previews: PreviewProvider {
    @State static var previewDeal = try! Deal(from: "S:A83.AT.AQT74.T72 Q74.KQ6.J9863.J4 J92.J742.K5.K965 KT65.9853.2.AQ83")
    static var previews: some View {
        DealView(deal: $previewDeal, showPoints: true)
        DealView(deal: $previewDeal,
                 players: [.north: "Ralph", .east: "Holdon", .south: "Lynda", .west: "Marc"],
                showPoints: false,
                 viewOption: .images)
    }
}
