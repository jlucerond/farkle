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

    init() {
        dice = []
        for _ in 1...6 {
            dice.append(getRandomDice())
        }
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
        print(randomNumber)
        return Dice(value: randomNumber)
    }
}
