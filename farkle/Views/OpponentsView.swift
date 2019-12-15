//
//  OpponentsView.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct OpponentsView: View {
    @State var opponents: [Opponent]

    var body: some View {
        HStack {
            VStack {
                ForEach(opponents) { opponent in
                    OpponentView(opponent: opponent, isCurrentlyRolling: false, isOpponentOnLeft: true)
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

struct OpponentsView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentsView(opponents: OpponentManager.opponents)
    }
}
