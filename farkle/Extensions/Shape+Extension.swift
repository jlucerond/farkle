//
//  Shape+Extension.swift
//  farkle
//
//  Created by Joe Lucero on 12/15/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import SwiftUI

struct HalfCircle: View {
    enum VisibleHalf {
        case left, right
    }
    var visibleHalf: VisibleHalf
//    .frame(width: 0.6 * geo.frame(in: .local).width,

    var body: some View {
        GeometryReader { geo in
            Circle()
                .offset(x: (geo.frame(in: .local).width / 2)  * (self.visibleHalf == .left ? 1 : -1), y: 0)
                .clipped()
        }
    }
}
//geo.frame(in: .local).width
struct HalfCirlce_Previews: PreviewProvider {
    static var previews: some View {
        HalfCircle(visibleHalf: .right)
        .frame(width: 100, height: 100, alignment: .leading)
    }
}
