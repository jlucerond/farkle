//
//  MainView.swift
//  farkle
//
//  Created by Joe Lucero on 12/14/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var numberOfOpponents = 5

    var body: some View {
        GeometryReader { geo in
            DiceRollingAreaView()
            .frame(width: 0.6 * geo.frame(in: .local).width,
                   height: geo.frame(in: .local).width,
                   alignment: .center)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
