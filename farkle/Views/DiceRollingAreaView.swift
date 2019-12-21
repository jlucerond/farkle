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
                ForEach(dice.indices) { index in
                    DiceView(dice: self._dice[index])
                    Spacer()
                }
            }
        }
    }
}

struct DiceRollingAreaView_Previews: PreviewProvider {
    @State static var diceExample = DiceManager().dice
    static var previews: some View {
        DiceRollingAreaView(dice: DiceRollingAreaView_Previews.$diceExample)
    }
}
