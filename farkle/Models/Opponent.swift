//
//  Opponent.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct Opponent: Player, Identifiable {
    var id = UUID()

    let name: String
    var score: Int
    var isCurrentlyRolling: Bool = false
    let riskStrategy: Int // TODO: - turn this into a whole other struct at some point

    typealias Decision = (scoresToKeep: [Score], willRollAgain: Bool)
    mutating func takeTurn(pointsThisRound: Int, scoresThisRoll: [Score], remainingDiceOnTable: Int) -> Decision {
        guard !scoresThisRoll.isEmpty else { return ([], false) }
//        var scoresToKeep: [Score] = []
        // TODO: - this needs to have more robust logic

        return (scoresThisRoll, false)
    }

    mutating func endTurn(roundScores: [Score]) {
        score += roundScores.reduce(0) { $0 + $1.points }
        isCurrentlyRolling = false
    }
}

