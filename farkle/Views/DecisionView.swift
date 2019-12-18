//
//  DecisionView.swift
//  farkle
//
//  Created by Joe Lucero on 12/18/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct DecisionView: View {
    @Binding var diceManager: DiceManager
    var body: some View {
        HStack {
            Button(action: {
                self.diceManager.rollAllDice()
            }) {
                Text("Roll\nDice")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Button(action: {
                self.diceManager.rollUnselectedDice()
            }) {
                Text("End\nTurn")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
    }
}

//struct DecisionView_Previews: PreviewProvider {
//    static var previews: some View {
//        DecisionView(diceManager: DiceManager())
//    }
//}
