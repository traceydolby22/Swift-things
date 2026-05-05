//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Tracey Bernstein on 5/4/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            pegs(colors: [.red, .blue, .green, .yellow])
            pegs(colors: [.red, .green, .blue, .yellow])
            pegs(colors: [.red, .red, .green, .green])
            pegs(colors: [.red, .yellow, .green, .green])
        }
        .padding()
    }
    func pegs(colors: Array<Color>) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarkers(matches: [.exact, .inExact, .noMatch])
        }
    }
   
}



#Preview {
    ContentView()
}
