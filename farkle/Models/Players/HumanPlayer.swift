//
//  HumanPlayer.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

protocol Player {
    var isCurrentlyRolling: Bool { get set }
    var score: Int { get set }
    mutating func endTurn(pointsScored: Int)
}

extension Player {
    mutating func endTurn(pointsScored: Int) {
        self.score += pointsScored
        self.isCurrentlyRolling = false
    }
}

struct HumanPlayer: Player {
    var score: Int
    var isCurrentlyRolling: Bool = false
}
