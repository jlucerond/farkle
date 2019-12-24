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
        guard var computer = playerManager.currentPlayer as? Opponent else {
            assertionFailure("Current Player is not an opponent")
            return
        }

        print("\(computer.name)'s turn")
        diceManager.rollUnselectedDice()
        let unselectedDice = diceManager.unselectedDice
        let scoresFromDice = scoreManager.getAllPossibleScoresFrom(dice: unselectedDice)
        let unusedDice = unselectedDice.count - scoresFromDice.reduce(0) { $0 + $1.diceUsed }
        let decision = computer.takeTurn(pointsThisRound: pointsThisRound, scoresThisRoll: scoresFromDice, remainingDiceOnTable: unusedDice)

        log(player: computer, unselectedDice: diceManager.unselectedDice, scores: scoresFromDice, scoresToKeep: decision.scoresToKeep, willRollAgain: decision.willRollAgain)

        if scoresFromDice.isEmpty {
            // No points scored this roll
            endTurnFor(&computer, pointsScored: 0)
        }

        if true {
            #warning("I need to remove the selected dice at this point.")
            pointsThisRound += decision.scoresToKeep.reduce(0) { $0 + $1.points }
        }

        if !decision.willRollAgain {
            endTurnFor(&computer, pointsScored: pointsThisRound)
        } else {
            simulateComputerTurn()
        }
    }

    mutating func playerRollsDice() {
        guard var human = playerManager.currentPlayer as? HumanPlayer else {
            assertionFailure("Human is not up!")
            return
        }

        #warning("this is temporary")
        diceManager.rollAllDice()
        
        let unselectedDice = diceManager.unselectedDice
        let scoresFromDice = scoreManager.getAllPossibleScoresFrom(dice: unselectedDice)

        let pointsFromDice = scoresFromDice.reduce(0) { $0 + $1.points }
        endTurnFor(&human, pointsScored: pointsFromDice)

        log(player: human, unselectedDice: unselectedDice, scores: scoresFromDice, scoresToKeep: scoresFromDice, willRollAgain: false)
    }

    private func log(player: Player, unselectedDice: [Dice], scores: [Score], scoresToKeep: [Score], willRollAgain: Bool) {
        if let _ = player as? HumanPlayer {
            print("Player has \(unselectedDice)")
        } else if let opponent = player as? Opponent {
            print("\(opponent.name) has \(unselectedDice)")
        }
        print("They have \(scores)")
        print("They are keeping \(scoresToKeep)")
        willRollAgain ? print("Roll again!") : print("End turn.")
    }

    private mutating func endTurnFor(_ opponent: inout Opponent, pointsScored: Int) {
        opponent.endTurn(pointsScored: pointsScored)
        playerManager.updateGame(player: opponent)
        pointsThisRound = 0
    }

    private mutating func endTurnFor(_ human: inout HumanPlayer, pointsScored: Int) {
        human.endTurn(pointsScored: pointsScored)
        playerManager.updateGame(player: human)
        pointsThisRound = 0
    }
}
