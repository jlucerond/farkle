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
                        .cornerRadius(geo.frame(in: .local).width / 10)
                        .opacity(0.8)
                }
            }
        }
        .onTapGesture {
            self.dice.isSelected = !self.dice.isSelected
        }
    }
}

//struct DiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//        DiceView(dice: Dice(value: 1, isSelected: false))
//        DiceView(dice: Dice(value: 3, isSelected: true))
//        DiceView(dice: Dice(value: 2, isSelected: false))
//        }
//    }
//}
