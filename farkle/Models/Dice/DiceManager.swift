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
    var unselectedDice: [Dice] { dice.filter { !$0.isSelected }}

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
            if !oneDice.isSelected {
                dice[index] = getRandomDice()
            }
        }
    }

    mutating func unselectAllDice() {
        for index in (0..<dice.count) {
            dice[index].isSelected = false
        }
    }

    mutating func select(dice diceToSelect: [Dice]) {
        topLoop: for oneDiceToSelect in diceToSelect {
            innerLoop: for (index, oneDice) in self.dice.enumerated() {
                if !oneDice.isSelected && oneDice.value == oneDiceToSelect.value {
                    self.dice[index].isSelected = true
                    continue topLoop
                }
            }
            #warning("Take this out and replace with an assertionFailure")
            print("We tried and failed to remove a 1")
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
