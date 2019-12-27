//
//  Score.swift
//  farkle
//
//  Created by Joe Lucero on 12/21/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct Score {
    let kind: ScoringCombination
    var points: Int {
        switch kind {
        case .twoTriples:
            return 2500
        case .fourOfAKind:
            return 1500
        case .threePairs:
            return 1500
        case .sixStraight:
            return 1500
        case .sixOfAKind:
            return 3000
        case .fiveOfAKind:
            return 2000
        case .fourOfAKindPlusPair:
            return 1500
        case .threeOfAKind(let value):
            if value == 1 {
                return 300
            } else {
                return value * 100
            }
        case .five:
            return 50
        case .one:
            return 100
        }
    }
    var diceUsed: Int {
        switch kind {
        case .twoTriples, .sixStraight, .sixOfAKind, .threePairs, .fourOfAKindPlusPair:
            return 6
        case .fiveOfAKind:
            return 5
        case .fourOfAKind:
            return 4
        case .threeOfAKind(diceValue: _):
            return 3
        case .five, .one:
            return 1
        }
    }
}

enum ScoringCombination {
    case twoTriples
    case fourOfAKind(diceValue: Int)
    case threePairs
    case sixStraight
    case sixOfAKind
    case fiveOfAKind(diceValue: Int)
    case fourOfAKindPlusPair
    case threeOfAKind(diceValue: Int)
    case five
    case one
}

extension Score: CustomDebugStringConvertible {
    var debugDescription: String {
        return "Score of kind:\(kind). Score: \(points)"
    }
}
