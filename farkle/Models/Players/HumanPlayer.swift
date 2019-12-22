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
}

struct HumanPlayer: Player {
    var score: Int
    var isCurrentlyRolling: Bool = false
}
