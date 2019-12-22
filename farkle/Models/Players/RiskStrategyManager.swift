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
        let maxDice = Int.random(in: 1...4)
        let scoresToKeep = RiskStrategyManager.randomScoresToKeep()
        let stoppingScoreForRound = RiskStrategyManager.randomMinimumStoppingScoreForRound()

        return RiskStrategy(maxDice: maxDice, scoresToKeep: scoresToKeep, minStopScore: stoppingScoreForRound)
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
