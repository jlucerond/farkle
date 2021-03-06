//
//  Opponent.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct Opponent: Player, Identifiable {
    var id: UUID = UUID()
    let name: String
    var score: Int
    var isCurrentlyRolling: Bool
    let riskStrategy: RiskStrategy = RiskStrategyManager.random()

    init(name: String, score: Int = 0, isCurrentlyRolling: Bool = false) {
        self.name = name
        self.score = score
        self.isCurrentlyRolling = isCurrentlyRolling
    }

    typealias Decision = (scoresToKeep: [Score], willRollAgain: Bool)
    func takeTurn(pointsThisRound: Int, scoresThisRoll: [Score], remainingDiceOnTable: Int) -> Decision {

        guard !scoresThisRoll.isEmpty else { return ([], false) }

        let totalPointsIfStoppingNow = pointsThisRound + scoresThisRoll.reduce(0) { $0 + $1.points }
        if shouldRollAgain(pointsThisRound: totalPointsIfStoppingNow, remainingDiceOnTable: remainingDiceOnTable) {
            let scoresToKeep = getScoresToKeep(allScoresThisRoll: scoresThisRoll)
            return (scoresToKeep, true)
        } else {
            // If we're not rolling again, take all of the points that you can
            return (scoresThisRoll, false)
        }
    }
}

private extension Opponent {
    func getScoresToKeep(allScoresThisRoll: [Score]) -> [Score] {
        guard allScoresThisRoll.count > 1 else { return allScoresThisRoll }
        switch riskStrategy.scoresToKeep {
        case .allOnesAndFives:
            return allScoresThisRoll
        case .allOnes:
            var scoresToKeep: [Score] = allScoresThisRoll.filter { $0.points > 50 }
            if scoresToKeep.isEmpty, let firstFive = allScoresThisRoll.first {
                scoresToKeep.append(firstFive)
            }
            return scoresToKeep
        case .singleOne:
            var scoresToKeep: [Score] = allScoresThisRoll.filter { $0.points > 100 }
            if let singleFive = allScoresThisRoll.first(where:{ $0.points == 100}) {
                scoresToKeep.append(singleFive)
            }
            return scoresToKeep
        }
    }

    func shouldRollAgain(pointsThisRound: Int, remainingDiceOnTable: Int) -> Bool {
        // Must have 500 points before you can stop
        guard pointsThisRound + score >= 500 else { return true }

        // Leaving this here in case I want to add another variable. Maybe stopping above 5000?
        if remainingDiceOnTable == 0 {
            return true
        }

        let hasEnoughPointsToStop = pointsThisRound > riskStrategy.minimumStoppingScoreForRound
        let hasEnoughDiceToRollAgain = remainingDiceOnTable > (6 - riskStrategy.preferredNumberOfDiceToHold)

        print("What should I do with \(pointsThisRound) points and \(remainingDiceOnTable) dice left?")

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

extension Opponent: CustomDebugStringConvertible {
    var debugDescription: String {
        "Name: \(name)."
    }
}
