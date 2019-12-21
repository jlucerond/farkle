//
//  PlayerManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/21/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct PlayerManager {
    var humanPlayer: HumanPlayer = HumanPlayer(score: 0, isCurrentlyRolling: false)
    var currentPlayer: Player?

    var opponents: [Opponent] = {
        let dad = Opponent(name: "Dad", score: 0, riskStrategy: 1)
        let joe = Opponent(name: "Joe", score: 500, isCurrentlyRolling: true, riskStrategy: 2)
        let dominic = Opponent(name: "Dominic", score: 7000, riskStrategy: 3)
        let sam = Opponent(name: "Samantha", score: 99999, riskStrategy: 4)

        return [dad, joe, dominic, sam]
    }()

    var leftOpponents: [Opponent] {
        var leftOpponents = [Opponent]()
        for (index, opponent) in opponents.enumerated() {
            if index % 2 == 0 {
                leftOpponents.append(opponent)
            }
        }
        return leftOpponents
    }

    var rightOpponents: [Opponent] {
        var rightOpponents = [Opponent]()
        for (index, opponent) in opponents.enumerated() {
            if index % 2 == 1 {
                rightOpponents.append(opponent)
            }
        }
        return rightOpponents
    }

    mutating func rearrangePlayers() {
        var newArray = [Opponent]()
        for player in opponents {
            if newArray.isEmpty {
                newArray.append(player)
            } else {
                let newIndex = Int.random(in: 0...newArray.count)
                newArray.insert(player, at: newIndex)
            }
        }
        opponents = newArray
    }
}
