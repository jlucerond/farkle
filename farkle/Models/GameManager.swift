//
//  GameManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

class GameManager {
    static var opponents: [Opponent] = {
        let dad = Opponent(name: "Dad", score: 0, riskStrategy: 1)
        let joe = Opponent(name: "Joe", score: 500, isCurrentlyRolling: true, riskStrategy: 2)
        let dominic = Opponent(name: "Dominic", score: 7000, riskStrategy: 3)
        let sam = Opponent(name: "Samantha", score: 99999, riskStrategy: 4)
        return [dad, joe, dominic, sam]
    }()

    static var leftOpponents: [Opponent] {
        var leftOpponents = [Opponent]()
        for (index, opponent) in GameManager.opponents.enumerated() {
            if index % 2 == 0 {
                leftOpponents.append(opponent)
            }
        }
        return leftOpponents
    }

    static var rightOpponents: [Opponent] {
        var rightOpponents = [Opponent]()
        for (index, opponent) in GameManager.opponents.enumerated() {
            if index % 2 == 1 {
                rightOpponents.append(opponent)
            }
        }
        return rightOpponents
    }

    static var player: Player = Player(score: 0, isCurrentlyRolling: false)
}
