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

    let value: Int
    var isSelected: Bool = false
    var image: Image {
        return Image("\(value)")
    }
}

extension Dice: CustomDebugStringConvertible {
    var debugDescription: String {
        "Dice: \(value)"
    }
}
