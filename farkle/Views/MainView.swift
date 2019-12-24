//
//  MainView.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State private var game: GameManager = GameManager()

    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack {
                    Spacer()
                    ForEach(game.playerManager.leftOpponents) { opponent in
                        OpponentView(opponent: opponent, isOpponentOnLeft: true)
                        Spacer()
                        Spacer()
                    }
                }

                DiceRollingAreaView(dice: $game.diceManager.dice)
                VStack {
                    Spacer()
                    ForEach(game.playerManager.rightOpponents) { opponent in
                        OpponentView(opponent: opponent, isOpponentOnLeft: false)
                        Spacer()
                        Spacer()
                    }
                }
            }
            DecisionView(gameManager: $game)
                .offset(y: 50)
            PlayerView(player: game.playerManager.humanPlayer)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
