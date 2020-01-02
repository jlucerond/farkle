//
//  DiceManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct DiceManager {
    var dice: [Dice]
    var unselectedDice: [Dice] { dice.filter { $0.selected == .unselected }}
    var diceSelectedThisTurn: [Dice] { dice.filter { $0.selected == .selectedThisRoll }}
    
    init() {
        dice = [
            Dice(value: 1),
            Dice(value: 2),
            Dice(value: 3),
            Dice(value: 4),
            Dice(value: 5),
            Dice(value: 6)
        ]
    }

    mutating func rollUnselectedDice() {
        for (index, oneDice) in dice.enumerated() {
            if oneDice.selected == .unselected {
                dice[index] = getRandomDice()
            }
        }
    }

    mutating func unselectAllDice() {
        for index in (0..<dice.count) {
            dice[index].selected = .unselected
        }
    }

    mutating func markAsUsedInPreviousRoll(dice diceToSelect: [Dice]) {
        topLoop: for oneDiceToSelect in diceToSelect {
            innerLoop: for (index, oneDice) in self.dice.enumerated() {
                if oneDice.selected != .selectedInPreviousRoll && oneDice.value == oneDiceToSelect.value {
                    self.dice[index].selected = .selectedInPreviousRoll
                    continue topLoop
                }
            }
            assertionFailure("Tried to remove a dice that was not in the unselected dice array.")
        }
    }

    mutating func resetDiceIfAllDiceHaveBeenUsed() {
        if unselectedDice.count == 0 {
            print("ALL DICE WERE USED!!!!")
            unselectAllDice()
        }
    }

    private func getRandomDice() -> Dice {
        let randomNumber = Int.random(in: 1...6)
        return Dice(value: randomNumber)
    }
}
