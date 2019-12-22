//
//  GameManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct GameManager {
    var diceManager: DiceManager = DiceManager()
    var playerManager: PlayerManager = PlayerManager()
    var scoreManager: ScoreManager = ScoreManager()

    private var pointsThisRound = 0

    mutating func takeTurn() {
        let currentPlayer = playerManager.currentPlayer

        if var human = currentPlayer as? HumanPlayer {
            print("Human player's turn... Skipping")
            human.isCurrentlyRolling = true

            // TODO: - Logic for how to handle Human
            endTurnForPlayer(scoresPoints: true)

        } else if var computer = currentPlayer as? Opponent {
            print("\(computer.name)'s turn")
            computer.isCurrentlyRolling = true
            diceManager.rollUnselectedDice()
            let unselectedDice = diceManager.unselectedDice
            let scoresFromDice = scoreManager.getAllPossibleScoresFrom(dice: unselectedDice)
            let unusedDice = unselectedDice.count - scoresFromDice.reduce(0) { $0 + $1.diceUsed }
            let decision = computer.takeTurn(pointsThisRound: pointsThisRound, scoresThisRoll: scoresFromDice, remainingDiceOnTable: unusedDice)

            log(opponent: computer, unselectedDice: diceManager.unselectedDice, scores: scoresFromDice, scoresToKeep: decision.scoresToKeep, willRollAgain: decision.willRollAgain)

            if scoresFromDice.isEmpty {
                // No points left
                print("No points to gain. Next turn.")
                endTurnFor(opponent: &computer, scoresPoints: false)
            }

            if true {
                #warning("I need to remove the selected dice at this point.")
                pointsThisRound += decision.scoresToKeep.reduce(0) { $0 + $1.points }
            }

            if !decision.willRollAgain {
                endTurnFor(opponent: &computer, scoresPoints: true)
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

    mutating func endTurnFor(opponent: inout Opponent, scoresPoints: Bool) {
        let scoreThisRound = scoresPoints ? pointsThisRound : 0
        opponent.endTurn(scoreThisRound: scoreThisRound)
        pointsThisRound = 0
        playerManager.endPlayersTurn()
    }

    mutating func endTurnForPlayer(scoresPoints: Bool) {
        playerManager.humanPlayer.score += scoresPoints ? pointsThisRound : 0
        playerManager.humanPlayer.isCurrentlyRolling = false
        pointsThisRound = 0
        playerManager.endPlayersTurn()
    }

}
