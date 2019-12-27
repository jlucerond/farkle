//
//  DiceView.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    @Binding var dice: Dice

    var body: some View {
        ZStack {
            dice.image
            .resizable()
            .scaledToFit()
                .shadow(color: .gray, radius: 3, x: 2, y: 2)

            if dice.isSelected {
                GeometryReader { geo in
                    Rectangle()
                        .foregroundColor(.gray)
                        .scaledToFit()
                        .cornerRadius(geo.frame(in: .local).width / 12)
                        .opacity(0.8)
                }
            }
        }
        .onTapGesture {
            #warning("Next fix is figuring out whether user should be able to tap")
            self.dice.isSelected = !self.dice.isSelected
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    @State static var diceManager: DiceManager = DiceManager()

    static var previews: some View {
        VStack {
            DiceView(dice: DiceView_Previews.$diceManager.dice[0])
            DiceView(dice: DiceView_Previews.$diceManager.dice[1])
            DiceView(dice: DiceView_Previews.$diceManager.dice[2])
        }
    }
}
