//
//  RiskStrategyManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/21/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct RiskStrategyManager {
    static func random() -> RiskStrategy {
        /// For example, if the number is 2, they will be ok keeping their score if they have scored with just 2 dice and not scored with 4 on the table
        let preferredNumberOfDiceToHold = Int.random(in: 2...5)
        let scoresToKeep = RiskStrategyManager.randomScoresToKeep()
        let stoppingScoreForRound = RiskStrategyManager.randomMinimumStoppingScoreForRound()

        return RiskStrategy(preferredNumberOfDiceToHold: preferredNumberOfDiceToHold, scoresToKeep: scoresToKeep, minStopScore: stoppingScoreForRound)
    }
}

private extension RiskStrategyManager {
    static func randomScoresToKeep() -> ScoresToKeep {
        switch Int.random(in: 1...3) {
        case 1:
            return .allOnes
        case 2:
            return .allOnesAndFives
        default:
            return .singleOne
        }
    }

    static func randomMinimumStoppingScoreForRound() -> Int {
        switch Int.random(in: 1...5) {
        case 1:
            return 200
        case 2:
            return 250
        case 3:
            return 300
        case 4:
            return 350
        default:
            return 400
        }
    }
}
