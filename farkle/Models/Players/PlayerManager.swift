//
//  PlayerManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/21/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct PlayerManager {
    var humanPlayer: HumanPlayer
    var opponents: [Opponent]

    init() {
        self.humanPlayer = HumanPlayer(score: 0)
        let dad = Opponent(name: "Dad", score: 0)
        let joe = Opponent(name: "Joe", score: 0)
        let dominic = Opponent(name: "Dominic", score: 0)
        let sam = Opponent(name: "Samantha", score: 0)

        let opponents = [dad, joe, dominic, sam]
        self.opponents = opponents
        self.currentIndex = Int.random(in: 0...opponents.count)
        rearrangePlayers()
    }

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

    private mutating func rearrangePlayers() {
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

    private var currentIndex: Int
    var currentPlayer: Player {
        switch currentIndex {
        case 0..<opponents.count:
            return opponents[currentIndex]
        default:
            return humanPlayer
        }
    }

    mutating func endPlayersTurn() {
        print("Player ends turn with: \(currentPlayer.score)")
        if currentIndex <= opponents.count {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }
}
