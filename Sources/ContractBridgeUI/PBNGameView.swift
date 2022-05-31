//
//  SwiftUIView.swift
//  
//
//  Created by Ralph Lipe on 5/28/22.
//

import SwiftUI
import ContractBridge

struct PBNGameView: View {
    var pbnGame: PBNGame
    @State var deal: Deal
    
    init(pbnGame: PBNGame) {
        let deal = pbnGame.deal ?? Deal()
        self.pbnGame = pbnGame
        self._deal = State(initialValue: deal)
    }
    
    var body: some View {
        VStack {
            if let event = pbnGame.event, !event.isEmpty {
                Text(event)
            }
            if let site = pbnGame.site, !site.isEmpty {
                Text(site)
            }
            if let date = pbnGame.date {
                Text("\(date)")
            }
            if let dealer = pbnGame.dealer {
                let d = "Dealer: \(dealer)"
                Text(d)
            }
            if let vulnerable = pbnGame.vulnerable {
                let v = "Vulnerable: \(vulnerable)"
                Text(v)
            }
            if pbnGame.deal != nil {
                DealView(deal: $deal, players: pbnGame.players)
            }
            if let scoring = pbnGame.scoring {
                Text("Scoring: \(scoring)")
            }
            if let contract = pbnGame.contract {
                if let declarer = pbnGame.declarer {
                    let c = "\(contract) by \(declarer)"
                    Text(c)
                } else {
                    let c = "\(contract)"
                    Text(c)
                }
            } else {
                if let declarer = pbnGame.declarer {
                    let d = "Declarer: \(declarer)"
                    Text(d)
                }
            }
            if let result = pbnGame.result {
                if let contract = pbnGame.contract,
                   let declarer = pbnGame.declarer {
                    let isVul = pbnGame.vulnerable != nil && pbnGame.vulnerable!.contains(declarer)
                    let r = "Result: \(result) tricks for score of \(contract.score(isVulnerable: isVul, tricksTaken: result))"
                    Text(r)
                } else {
                    let r = "Result: \(result) tricks"
                    Text(r)
                }
            }
            if let dd = pbnGame.doubleDummyTricks {
                VStack {
                    DoubleDummyTricksView(doubleDummyTricks: dd, pair: .ns)
                    DoubleDummyTricksView(doubleDummyTricks: dd, pair: .ew)
                }.padding()
            }
        }
    }
}

@available(macOS 12, *)
struct PBNGameView_Previews: PreviewProvider {
    public static var previewGame = PBNGame(event: "Monday afternoon pairs", site: "Eastside Bridge", date: Date.now, board: 1, players: [.north: "Ralph Lipe", .east: "David Johnson", .south: "Lynda Lipe", .west: "Fred Smith"], dealer: .west, vulnerable: [.ew], deal: try! Deal(from: "S:A83.AT.AQT74.T72 Q74.KQ6.J9863.J4 J92.J742.K5.K965 KT65.9853.2.AQ83"), scoring: "Matchpoints", declarer: .east, contract: Contract(level: 3, strain: .hearts, risk: .undoubled), result: 10, doubleDummyTricks: DoubleDummyTricks(from: "3321534215a9bc8aabc8"))
    
    static var previews: some View {
        PBNGameView(pbnGame: PBNGameView_Previews.previewGame)
    }
}
