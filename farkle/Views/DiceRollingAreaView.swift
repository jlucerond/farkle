//
//  DiceRollingAreaView.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct DiceRollingAreaView: View {
    @Binding var dice: [Dice]
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.brown)
            VStack {
                Spacer()
                // TODO: - Why doesn't this work here with Bindings?
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
