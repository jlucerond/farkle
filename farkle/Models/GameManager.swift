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
        let currentPlayer = playerManager.getNextPlayer()

        if var human = currentPlayer as? HumanPlayer {
            print("Human player's turn")
            human.isCurrentlyRolling = true
        } else if var computer = currentPlayer as? Opponent {
            print("\(computer.name)'s turn")
            computer.isCurrentlyRolling = true
            diceManager.rollAllDice()
            let unselectedDice = diceManager.unselectedDice
            let scoresFromDice = scoreManager.getAllPossibleScoresFrom(dice: unselectedDice)
            let remainingDiceOnTable = unselectedDice.count
//            let remainigDiceOnTable = dicemanag
//            computer.takeTurn(pointsThisRound: pointsThisRound, scoresThisRoll: scoresFromDice, remainingDiceOnTable: <#T##Int#>)
        }
    }

    mutating func endTurn() {
        // TODO: WTF. I should have made these all classes. i hate SwiftUI
//        playerManager.currentPlayer.isCurrentlyRolling = false
        
    }

}
