//
//  Opponent.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct Opponent: Identifiable {
    var id = UUID()

    let name: String
    var score: Int
    var isCurrentlyRolling: Bool = false
    let riskStrategy: Int // TODO: - turn this into a whole other struct at some point
}
