//
//  Opponent.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct Opponent: Identifiable {
    var id = UUID()

    let name: String
    var score: Int
    let riskStrategy: Int // TODO: - turn this into a whole other struct at some point
}

class OpponentManager {
    static var opponents: [Opponent] = {
        let dad = Opponent(name: "Dad", score: 0, riskStrategy: 1)
        let joe = Opponent(name: "Joe", score: 100, riskStrategy: 2)
        let dominic = Opponent(name: "Dominic", score: 7000, riskStrategy: 3)
        let sam = Opponent(name: "Samantha", score: 99999, riskStrategy: 4)
        return [dad, joe, dominic, sam]
    }()
}
