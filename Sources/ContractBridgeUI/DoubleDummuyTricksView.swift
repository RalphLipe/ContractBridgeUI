//
//  SwiftUIView.swift
//  
//
//  Created by Ralph Lipe on 5/27/22.
//


import SwiftUI
import ContractBridge


struct DoubleDummyTricksView: View {
    var pair: Pair
    var tricks0: [Strain : Int]
    var tricks1: [Strain : Int]
    
    init(doubleDummyTricks: DoubleDummyTricks, pair: Pair) {
        self.pair = pair
        let pos = pair.positions
        self.tricks0 = doubleDummyTricks[pos.0]
        self.tricks1 = doubleDummyTricks[pos.1]
    }
    
    func makingTricks(_ a: Int, _ b: Int, _ strain: Strain) -> Text {
        let tricks = (a == b) ? "\(a-6)" : "\(a-6)/\(b-6)"
        return Text(tricks) +
            Text(strain.shortDescription).foregroundColor(strain.color)
    }
    
    func underTricks(_ a: Int, _ b: Int, _ strain: Strain) -> Text {
        let tricks = (a == b) ? "\(a)" : "\(a)/\(b)"
        return Text(strain.shortDescription).foregroundColor(.blue) +
            Text(tricks).foregroundColor(.blue)
    }

    var body: some View {
        HStack {
            Text(self.pair.shortDescription)
            ForEach (Strain.allCases, id: \.self) { strain in
                if let a = tricks0[strain],
                   let b = tricks1[strain] {
                    if a > 6 {
                        if b > 6 {
                            makingTricks(a, b, strain)
                        } else {
                            makingTricks(a, a, strain) +
                            Text("/") +
                            underTricks(b, b, strain)
                        }
                    } else {
                        if b <= 6 {
                            underTricks(a, b, strain)
                        } else {
                            underTricks(a, a, strain) +
                            Text("/") +
                            makingTricks(b, b, strain)
                        }
                    }

                }
            }
        }
    }
}

struct DoubleDummyView_Previews: PreviewProvider {
    static var dd = DoubleDummyTricks(from: "3321534215a9bc8aabc8")!
    
    
    static var previews: some View {
        VStack {
            DoubleDummyTricksView(doubleDummyTricks: dd, pair: .ns)
            DoubleDummyTricksView(doubleDummyTricks: dd, pair: .ew)
        }
    }
}
