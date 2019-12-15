//
//  OpponentView.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct OpponentView: View {
    @State var opponent: Opponent
    @State var isCurrentlyRolling: Bool
    let isOpponentOnLeft: Bool
    let width: CGFloat = 100

    var body: some View {
        ZStack {
            Ellipse()
                .foregroundColor(isCurrentlyRolling ? .green : .red)
                .opacity(0.2)
                .transformEffect(.init(translationX: width/2 * (isOpponentOnLeft ? -1 : 1), y: 0))
                .clipped()
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
    static var previews: some View {
        OpponentView(opponent: OpponentManager.opponents.last!, isCurrentlyRolling: true, isOpponentOnLeft: true)
    }
}
