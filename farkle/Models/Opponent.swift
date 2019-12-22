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
    let riskStrategy: RiskStrategy = RiskStrategyManager.random()

    typealias Decision = (scoresToKeep: [Score], willRollAgain: Bool)
    mutating func takeTurn(pointsThisRound: Int, scoresThisRoll: [Score], remainingDiceOnTable: Int) -> Decision {
        guard !scoresThisRoll.isEmpty else { return ([], false) }

        let totalPointsIfStoppingNow = pointsThisRound + scoresThisRoll.reduce(0) { $0 + $1.points }
        if shouldRollAgain(pointsThisRound: totalPointsIfStoppingNow, remainingDiceOnTable: remainingDiceOnTable) {
            let scoresToKeep = whichScoresToKeep(scoresThisRoll: scoresThisRoll)
            return (scoresToKeep, true)
        } else {
            // If we're not rolling again, take all of the points that you can
            return (scoresThisRoll, false)
        }
    }

    mutating func endTurn(roundScores: [Score]) {
        score += roundScores.reduce(0) { $0 + $1.points }
        isCurrentlyRolling = false
    }
}

private extension Opponent {
    func whichScoresToKeep(scoresThisRoll: [Score]) -> [Score] {
        guard scoresThisRoll.count > 1 else { return scoresThisRoll }
        switch riskStrategy.scoresToKeep {
        case .allOnesAndFives:
            return scoresThisRoll
        case .allOnes:
            var scoresToKeep: [Score] = scoresThisRoll.filter { $0.points > 50 }
            if scoresToKeep.isEmpty, let firstFive = scoresThisRoll.first {
                scoresToKeep.append(firstFive)
            }
            return scoresToKeep
        case .singleOne:
            var scoresToKeep: [Score] = scoresThisRoll.filter { $0.points > 100 }
            if let singleFive = scoresThisRoll.first(where:{ $0.points == 100}) {
                scoresToKeep.append(singleFive)
            }
            return scoresToKeep
        }
    }

    func shouldRollAgain(pointsThisRound: Int, remainingDiceOnTable: Int) -> Bool {
        // Must have 500 points before you can stop
        guard pointsThisRound + score >= 500 else { return true }

        let hasEnoughPointsToStop = pointsThisRound > riskStrategy.minimumStoppingScoreForRound
        let hasEnoughDiceToRollAgain = remainingDiceOnTable > riskStrategy.maxDiceRemainingAllowed

        switch (hasEnoughPointsToStop, hasEnoughDiceToRollAgain) {
        case (true, true):
            return riskStrategy.willUserRollAgainOnCloseCall()
        case (true, false):
            return false
        case (false, true):
            return true
        case (false, false):
            return riskStrategy.willUserRollAgainOnCloseCall()
        }
    }
}
