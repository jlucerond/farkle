//
//  DecisionView.swift
//  farkle
//
//  Created by Joe Lucero on 12/18/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct DecisionView: View {
    @Binding var gameManager: GameManager
    var body: some View {
        HStack {
            Button(action: {
                self.gameManager.takeTurn()
            }) {
                Text("Have computer Roll")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Button(action: {
                self.gameManager.diceManager.rollUnselectedDice()
            }) {
                Text("Roll Dice")
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

struct DecisionView_Previews: PreviewProvider {
    @State static var gameManager: GameManager = GameManager()
    static var previews: some View {
        DecisionView(gameManager: DecisionView_Previews.$gameManager)
    }
}
