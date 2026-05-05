//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Tracey Bernstein on 5/4/26.
//

import SwiftUI

enum Match {
    case noMatch
    case exact
    case inExact
    
}

struct MatchMarkers: View {
    var matches: [Match]
    var body: some View {
        HStack {
            VStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
                
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }
    @ViewBuilder
    func matchMarker(peg: Int) -> some View {
        let exactCount: Int = matches.count {$0 == .exact}
        let foundCount: Int = matches.count(where: {match in match != .noMatch})
        Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear )
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2).aspectRatio(1, contentMode: .fit)
    }
       
}
#Preview {
    MatchMarkers(matches: [.exact, .inExact, .noMatch])
}
