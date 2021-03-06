//
//  OpponentView.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct OpponentView: View {
    var opponent: Opponent
    let isOpponentOnLeft: Bool
    let width: CGFloat = 100

    var body: some View {
        ZStack {
            HalfCircle(visibleHalf: isOpponentOnLeft ? .right : .left)
                .foregroundColor(self.opponent.isCurrentlyRolling ? .green : .red)
                .opacity(0.2)
            VStack {
                Text(opponent.name)
                    .font(.headline)
                Text("\(opponent.score)")
                    .font(.subheadline)
            }
        }
        .frame(width: width, height: width, alignment: .center)
    }
}

struct OpponentView_Previews: PreviewProvider {
    static let joe = Opponent(name: "Joe", score: 1500, isCurrentlyRolling: true)
    static var previews: some View {
        OpponentView(opponent: OpponentView_Previews.joe, isOpponentOnLeft: true)
    }
}
