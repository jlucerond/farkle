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
        VStack {
            Button(action: {
                self.gameManager.simulateComputerTurn()
            }) {
                Text("Opponents Turn")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .opacity(gameManager.playerManager.isHumanPlayersTurn ? 0.5 : 1.0)
            }
            .disabled(gameManager.playerManager.isHumanPlayersTurn)

            Button(action: {
                self.gameManager.playerRollsDice()
            }) {
                Text("Roll Again")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .background(Color.red)
                    .opacity(gameManager.playerManager.isHumanPlayersTurn && gameManager.humanHasTakenValidTurn ? 1.0 : 0.5)
            }
            .disabled(!gameManager.playerManager.isHumanPlayersTurn || !gameManager.humanHasTakenValidTurn)

            Button(action: {
                self.gameManager.playerEndsTurn()
            }) {
                Text("End Turn")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .background(Color.red)
                    .opacity(gameManager.playerManager.isHumanPlayersTurn ? 1.0 : 0.5)
            }
            .disabled(!gameManager.playerManager.isHumanPlayersTurn)

        }
    }
}

struct DecisionView_Previews: PreviewProvider {
    @State static var gameManager: GameManager = GameManager()
    static var previews: some View {
        DecisionView(gameManager: DecisionView_Previews.$gameManager)
    }
}
