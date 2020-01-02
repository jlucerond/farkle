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
    var humanHasTakenValidTurn: Bool {
        guard !diceManager.diceSelectedThisTurn.isEmpty else { return false }
        return !scoreManager.getAllPossibleScoresFrom(dice: diceManager.diceSelectedThisTurn).isEmpty
    }

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
            let diceUsedForPoints: [Dice] = scoreManager.getDiceNeedFor(scores: decision.scoresToKeep, from: unselectedDice).map { (dice) -> Dice in
                return Dice(id: dice.id, value: dice.value, selected: .selectedThisRoll)
            }
            diceManager.markAsUsedInPreviousRoll(dice: diceUsedForPoints)
            diceManager.resetDiceIfAllDiceHaveBeenUsed()
            simulateComputerTurn()
        }
    }

    mutating func playerRollsDice() {
        guard let human = playerManager.currentPlayer as? HumanPlayer else {
            assertionFailure("Human is not up!")
            return
        }

        let diceToKeep = diceManager.diceSelectedThisTurn.map { (dice) -> Dice in
            return Dice(id: dice.id, value: dice.value, selected: .selectedThisRoll)
        }
        let scores = scoreManager.getAllPossibleScoresFrom(dice: diceToKeep)

        let diceAvailable = diceManager.dice.filter { $0.selected != .selectedInPreviousRoll }
        log(player: human, unselectedDice: diceAvailable, scores: scores, scoresToKeep: scores, willRollAgain: true)

        pointsThisRound += scores.reduce(0) { $0 + $1.points }
        diceManager.markAsUsedInPreviousRoll(dice: diceToKeep)
        diceManager.resetDiceIfAllDiceHaveBeenUsed()
        diceManager.rollUnselectedDice()
    }

    mutating func playerEndsTurn() {
        guard var human = playerManager.currentPlayer as? HumanPlayer else {
            assertionFailure("Human is not up!")
            return
        }

        let diceSelectedThisRound = diceManager.diceSelectedThisTurn
        let scoresLeft = scoreManager.getAllPossibleScoresFrom(dice: diceSelectedThisRound)

        let totalPoints: Int
        if scoresLeft.isEmpty {
            totalPoints = 0
        } else {
            totalPoints = pointsThisRound + scoresLeft.reduce(0) { $0 + $1.points }
        }

        let diceAvailable = diceManager.dice.filter { $0.selected != .selectedInPreviousRoll }
        log(player: human, unselectedDice: diceAvailable, scores: scoresLeft, scoresToKeep: scoresLeft, willRollAgain: false)
        endTurnFor(&human, pointsScored: totalPoints)
    }

    private mutating func endTurnFor(_ opponent: inout Opponent, pointsScored: Int) {
        print("End turn for \(opponent.name) with \(pointsScored) points scored")
        let pointsToAdd = (opponent.score + pointsScored >= 500) ? pointsScored : 0
        opponent.endTurn(pointsScored: pointsToAdd)
        playerManager.endTurnFor(opponent)
        resetBoard()
    }

    private mutating func endTurnFor(_ human: inout HumanPlayer, pointsScored: Int) {
        print("End turn for human with \(pointsScored) points scored")
        let pointsToAdd = (human.score + pointsScored >= 500) ? pointsScored : 0
        human.endTurn(pointsScored: pointsToAdd)
        playerManager.endTurnFor(human)
        resetBoard()
    }

    private mutating func resetBoard() {
        diceManager.unselectAllDice()
        pointsThisRound = 0
    }

    private func log(player: Player, unselectedDice: [Dice], scores: [Score], scoresToKeep: [Score], willRollAgain: Bool) {
        if playerManager.isHumanPlayersTurn {
            print("Player has \(unselectedDice)")
        } else if let opponent = player as? Opponent {
            print("\(opponent.name) has \(unselectedDice)")
        }
        print("They have \(scores)")
        print("They are keeping \(scoresToKeep)")
        willRollAgain ? print("Roll again!") : print("End turn.")
    }
}
