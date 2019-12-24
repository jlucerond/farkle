//
//  GameManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct GameManager {
    var diceManager: DiceManager = DiceManager()
    var playerManager: PlayerManager = PlayerManager()
    var scoreManager: ScoreManager = ScoreManager()

    private var pointsThisRound = 0

    mutating func simulateComputerTurn() {
        guard  var computer = playerManager.currentPlayer as? Opponent else {
            assertionFailure("Current Player is not an opponent")
            return
        }

        print("\(computer.name)'s turn")
        diceManager.rollUnselectedDice()
        let unselectedDice = diceManager.unselectedDice
        let scoresFromDice = scoreManager.getAllPossibleScoresFrom(dice: unselectedDice)
        let unusedDice = unselectedDice.count - scoresFromDice.reduce(0) { $0 + $1.diceUsed }
        let decision = computer.takeTurn(pointsThisRound: pointsThisRound, scoresThisRoll: scoresFromDice, remainingDiceOnTable: unusedDice)

        log(opponent: computer, unselectedDice: diceManager.unselectedDice, scores: scoresFromDice, scoresToKeep: decision.scoresToKeep, willRollAgain: decision.willRollAgain)

        if scoresFromDice.isEmpty {
            // No points scored this roll
            endTurnFor(opponent: &computer, pointsScored: 0)
        }

        if true {
            #warning("I need to remove the selected dice at this point.")
            pointsThisRound += decision.scoresToKeep.reduce(0) { $0 + $1.points }
        }

        if !decision.willRollAgain {
            endTurnFor(opponent: &computer, pointsScored: pointsThisRound)
        } else {
            simulateComputerTurn()
        }
    }

    func log(opponent: Opponent, unselectedDice: [Dice], scores: [Score], scoresToKeep: [Score], willRollAgain: Bool) {
        print("\(opponent.name) has \(unselectedDice)")
        print("They have \(scores)")
        print("They are keeping \(scoresToKeep)")
        willRollAgain ? print("Roll again!") : print("End turn.")
    }

    mutating func endTurnFor(opponent: inout Opponent, pointsScored: Int) {
        opponent.endTurn(pointsScored: pointsScored)
        playerManager.updateGame(player: opponent)
        pointsThisRound = 0
    }
}
