//
//  RiskStrategy.swift
//  farkle
//
//  Created by Joe Lucero on 12/21/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct RiskStrategy {
    let maxDiceRemainingAllowed: Int
    let scoresToKeep: ScoresToKeep
    let minimumStoppingScoreForRound: Int
    /// This should be a number from 1 to 99. Used for the function willUserRollAgainOnCloseCall. Higher number means player is more likely to go for it.
    private let randomPercentageToGoForIt: Int

    init(maxDice: Int, scoresToKeep: ScoresToKeep, minStopScore: Int) {
        self.maxDiceRemainingAllowed = maxDice
        self.scoresToKeep = scoresToKeep
        self.minimumStoppingScoreForRound = minStopScore
        self.randomPercentageToGoForIt = Int.random(in: 1...99)
    }

    func willUserRollAgainOnCloseCall() -> Bool {
        Int.random(in: 0...100) < randomPercentageToGoForIt ? true : false
    }
}

enum ScoresToKeep {
    case allOnesAndFives
    case allOnes
    case singleOne
}
