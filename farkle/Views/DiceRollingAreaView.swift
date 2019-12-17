//
//  DiceRollingAreaView.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct DiceRollingAreaView: View {
    var dice: [Dice]
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.brown)
            VStack {
                Spacer()
                ForEach(dice) { singleDice in
                    DiceView(dice: singleDice)
                    Spacer()
                }
            }
        }
    }
}

struct DiceRollingAreaView_Previews: PreviewProvider {
    static var previews: some View {
        DiceRollingAreaView(dice: DiceManager().dice)
    }
}
