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

    mutating func takeTurn() {
        var currentPlayer = playerManager.currentPlayer

        if let _ = currentPlayer as? HumanPlayer {
            print("Human player's turn... Skipping")
            currentPlayer.isCurrentlyRolling = true

            // TODO: - Logic for how to handle Human
            endTurnFor(player: &currentPlayer, pointsScored: 50)


        } else if let computer = currentPlayer as? Opponent {
            print("\(computer.name)'s turn")
            currentPlayer.isCurrentlyRolling = true
            diceManager.rollUnselectedDice()
            let unselectedDice = diceManager.unselectedDice
            let scoresFromDice = scoreManager.getAllPossibleScoresFrom(dice: unselectedDice)
            let unusedDice = unselectedDice.count - scoresFromDice.reduce(0) { $0 + $1.diceUsed }
            let decision = computer.takeTurn(pointsThisRound: pointsThisRound, scoresThisRoll: scoresFromDice, remainingDiceOnTable: unusedDice)

            log(opponent: computer, unselectedDice: diceManager.unselectedDice, scores: scoresFromDice, scoresToKeep: decision.scoresToKeep, willRollAgain: decision.willRollAgain)

            if scoresFromDice.isEmpty {
                // No points scored this roll
                endTurnFor(player: &currentPlayer, pointsScored: 0)
            }

            if true {
                #warning("I need to remove the selected dice at this point.")
                pointsThisRound += decision.scoresToKeep.reduce(0) { $0 + $1.points }
            }

            if !decision.willRollAgain {
                endTurnFor(player: &currentPlayer, pointsScored: pointsThisRound)
            } else {
                takeTurn()
            }
        }
    }

    func log(opponent: Opponent, unselectedDice: [Dice], scores: [Score], scoresToKeep: [Score], willRollAgain: Bool) {
        print("\(opponent.name) has \(unselectedDice)")
        print("They have \(scores)")
        print("They are keeping \(scoresToKeep)")
        willRollAgain ? print("Roll again!") : print("End turn.")
    }

    mutating func endTurnFor(player: inout Player, pointsScored: Int) {
        player.endTurn(pointsScored: pointsScored)
        playerManager.updateGame(player: player)
        pointsThisRound = 0
    }
}
