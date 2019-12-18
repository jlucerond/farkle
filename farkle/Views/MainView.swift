//
//  MainView.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack {
                    Spacer()
                    ForEach(GameManager.leftOpponents) { opponent in
                        OpponentView(opponent: opponent, isOpponentOnLeft: true)
                        Spacer()
                        Spacer()
                    }
                }

                DiceRollingAreaView(dice: DiceManager().dice)
                VStack {
                    Spacer()
                    ForEach(GameManager.rightOpponents) { opponent in
                        OpponentView(opponent: opponent, isOpponentOnLeft: false)
                        Spacer()
                        Spacer()
                    }
                }
            }
            PlayerView(player: GameManager.player)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
