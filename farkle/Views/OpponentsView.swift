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
        ForEach(opponents) { opponent in
            Circle()
        }
    }
}

struct OpponentsView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentsView(opponents: OpponentManager.opponents)
    }
}
