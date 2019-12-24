//
//  PlayerView.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    var player: HumanPlayer
    let width: CGFloat = 200

    var body: some View {
        ZStack {
            HalfCircle(visibleHalf: .top)
                .foregroundColor(self.player.isCurrentlyRolling ? .green : .red)
                .opacity(0.2)
            VStack {
                Spacer()
                Text("Current Score")
                Text("\(player.score)")
                    .font(.headline)
                .baselineOffset(10)
            }
        }
        .frame(width: width, height: width, alignment: .center)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: HumanPlayer(score: 1950, isCurrentlyRolling: false))
    }
}
