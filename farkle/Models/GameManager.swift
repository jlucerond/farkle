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

        // Roll unselected dice and see how many points that you could get
        diceManager.rollUnselectedDice()
        let unselectedDice = diceManager.unselectedDice
        let scoresFromDice = scoreManager.getAllPossibleScoresFrom(dice: unselectedDice)

        // If no scores, then end turn
        if scoresFromDice.isEmpty {
            // No points scored this roll
            log(player: computer, unselectedDice: unselectedDice, scores: scoresFromDice, scoresToKeep: [], willRollAgain: false)
            endTurnFor(&computer, pointsScored: 0)
            return
        }

        // Based on how many points and dice WOULD be leftover, figure out whether to roll again
        let unusedDice = unselectedDice.count - scoresFromDice.reduce(0) { $0 + $1.diceUsed }

        let decision = computer.takeTurn(pointsThisRound: pointsThisRound, scoresThisRoll: scoresFromDice, remainingDiceOnTable: unusedDice)
        pointsThisRound += decision.scoresToKeep.reduce(0) { $0 + $1.points }

        log(player: computer, unselectedDice: unselectedDice, scores: scoresFromDice, scoresToKeep: decision.scoresToKeep, willRollAgain: decision.willRollAgain)

        if !decision.willRollAgain {
            // End Turn
            endTurnFor(&computer, pointsScored: pointsThisRound)
        } else {
            // Go Again
            let diceUsedForPoints: [Dice] = scoreManager.getDiceNeedFor(scores: decision.scoresToKeep, from: unselectedDice)
            diceManager.select(dice: diceUsedForPoints)
            diceManager.resetDiceIfAllDiceHaveBeenUsed()
            simulateComputerTurn()
        }
    }

    mutating func playerRollsDice() {
        guard var human = playerManager.currentPlayer as? HumanPlayer else {
            assertionFailure("Human is not up!")
            return
        }

        #warning("this is temporary")
        diceManager.rollUnselectedDice()


//        let unselectedDice = diceManager.unselectedDice
//        let scoresFromDice = scoreManager.getAllPossibleScoresFrom(dice: unselectedDice)
//
//        let pointsFromDice = scoresFromDice.reduce(0) { $0 + $1.points }
//
//        let willRollAgain = unselectedDice.count > 1
//        if !willRollAgain {
//            endTurnFor(&human, pointsScored: pointsFromDice)
//            diceManager.unselectAllDice()
//        } else {
//            // TODO: -
//        }

//        log(player: human, unselectedDice: unselectedDice, scores: scoresFromDice, scoresToKeep: scoresFromDice, willRollAgain: willRollAgain)
    }

    mutating func playerEndsTurn() {
        guard var human = playerManager.currentPlayer as? HumanPlayer else {
            assertionFailure("Human is not up!")
            return
        }

        endTurnFor(&human, pointsScored: pointsThisRound)
    }

    private mutating func endTurnFor(_ opponent: inout Opponent, pointsScored: Int) {
        print("End turn for \(opponent.name) with \(pointsScored) points scored")
        opponent.endTurn(pointsScored: pointsScored)
        playerManager.endTurnFor(opponent)
        diceManager.unselectAllDice()
        pointsThisRound = 0
    }

    private mutating func endTurnFor(_ human: inout HumanPlayer, pointsScored: Int) {
        print("End turn for human with \(pointsScored) points scored")
        human.endTurn(pointsScored: pointsScored)
        playerManager.endTurnFor(human)
        diceManager.unselectAllDice()
        pointsThisRound = 0
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
}
