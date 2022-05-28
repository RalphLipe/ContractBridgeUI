//
//  DealView.swift
//  PBNView
//
//  Created by Ralph Lipe on 2/13/22.
//

import SwiftUI
import ContractBridge

struct DealView: View {
    var deal: Deal
    var showPoints: Bool = false

    var body: some View {
        VStack {
            HandView(hand: deal[.north])
            HStack {
                HandView(hand: deal[.west])
                Spacer()
                if showPoints {
                    VStack {
                        Text("\(deal[.north].highCardPoints)")
                        HStack {
                            Text("\(deal[.west].highCardPoints)")
                            Spacer()
                            Text("\(deal[.east].highCardPoints)")
                        }
                        Text("\(deal[.south].highCardPoints)")
                    }.padding()
                    Spacer()
                }
                HandView(hand: deal[.east])
            }.padding()
            HandView(hand: deal[.south])
        }
    }
}

struct DealView_Previews: PreviewProvider {
    static var previews: some View {
        DealView(deal: try! Deal(from: "S:A83.AT.AQT74.T72 Q74.KQ6.J9863.J4 J92.J742.K5.K965 KT65.9853.2.AQ83"), showPoints: true)
    }
}
