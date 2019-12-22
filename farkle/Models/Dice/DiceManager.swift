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

    mutating func rollAllDice() {
        dice = []
        for _ in 1...6 {
            dice.append(getRandomDice())
        }
    }

    mutating func rollUnselectedDice() {
        for (index, oneDice) in dice.enumerated() {
            if !oneDice.isSelected {
                dice[index] = getRandomDice()
            }
        }
    }

    private func getRandomDice() -> Dice {
        let randomNumber = Int.random(in: 1...6)
        return Dice(value: randomNumber)
    }
}
