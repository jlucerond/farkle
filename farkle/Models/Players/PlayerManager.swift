//
//  PlayerManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/21/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct PlayerManager {
    private(set) var humanPlayer: HumanPlayer = HumanPlayer(score: 0)
    private(set) var opponents: [Opponent] = [
        Opponent(name: "Dad", score: 0),
        Opponent(name: "Joe", score: 0),
        Opponent(name: "Dominic", score: 0),
        Opponent(name: "Samantha", score: 0)
    ]

    init() {
        randomizePlayers()
        var firstPlayer = currentPlayer
        firstPlayer.isCurrentlyRolling = true
        self.save(player: firstPlayer)
    }

    var isHumanPlayersTurn: Bool { currentPlayer as? HumanPlayer != nil }
    private var currentIndex: Int = 0
    private(set) var currentPlayer: Player {
        get {
            switch currentIndex {
            case 0..<opponents.count:
                return opponents[currentIndex]
            default:
                return humanPlayer
            }
        } set {
            switch currentIndex {
            case 0..<opponents.count:
                guard let opponent = newValue as? Opponent else { return }
                self.opponents[currentIndex] = opponent
            default:
                guard let humanPlayer = newValue as? HumanPlayer else { return }
                self.humanPlayer = humanPlayer
            }
        }
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

    mutating func endTurnFor(_ player: Player) {
        // Update the player above
        var player = player
        player.isCurrentlyRolling = false
        save(player: player)

        startTurnForNextPlayer()
    }
}

private extension PlayerManager {
    mutating func randomizePlayers() {
        // randomize players
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

        // randomize who goes first
        currentIndex = Int.random(in: 0...opponents.count)
    }

    mutating func startTurnForNextPlayer() {
        // Change the current index
        if currentIndex <= opponents.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }

        var nextPlayer = currentPlayer
        print("next player is \(nextPlayer)")
        nextPlayer.isCurrentlyRolling = true
        save(player: nextPlayer)
    }

    mutating func save(player: Player) {
        if let player = player as? Opponent, let index = opponents.firstIndex(where: { $0.id == player.id }) {
            opponents[index] = player
        } else if let human = player as? HumanPlayer {
            self.humanPlayer = human
        }
    }
}
