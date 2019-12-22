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

    init() {
        playerManager.rearrangePlayers()
    }
}
