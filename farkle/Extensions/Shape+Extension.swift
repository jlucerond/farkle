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
        case left, right, top
    }
    var visibleHalf: VisibleHalf
//    .frame(width: 0.6 * geo.frame(in: .local).width,

    var body: some View {
        GeometryReader { geo in
            Circle()
                .offset(x: (self.visibleHalf == .left ? 1 : 0) * (geo.frame(in: .local).width / 2), y: 0)
                .offset(x: (self.visibleHalf == .right ? -1 : 0) * (geo.frame(in: .local).width / 2), y: 0)
                .offset(x: 0, y: (self.visibleHalf == .top ? 1 : 0) * (geo.frame(in: .local).height / 2))
                .clipped()
        }
    }
}
//geo.frame(in: .local).width
struct HalfCirlce_Previews: PreviewProvider {
    static var previews: some View {
        HalfCircle(visibleHalf: .right)
        .frame(width: 300, height: 200, alignment: .leading)
    }
}
