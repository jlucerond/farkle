//
//  Dice.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct Dice: Identifiable {
    var id: UUID = UUID()

    /// 1-6
    let value: Int
    /// Used to determine whether the human player has selected the dice this turn
    var selected: State = .unselected
    var image: Image {
        return Image("\(value)")
    }

    enum State {
        case unselected
        case selectedThisRoll
        case selectedInPreviousRoll
    }
}

extension Dice: CustomDebugStringConvertible {
    var debugDescription: String {
        "Dice: \(value)"
    }
}
