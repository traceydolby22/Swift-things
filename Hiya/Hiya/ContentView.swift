//
//  ContentView.swift
//  Hiya
//
//  Created by Tracey Bernstein on 5/3/26.
//

import SwiftUI
import FoundationModels // large language model AI

struct ContentView: View {
    private var largeLanguageModel = SystemLanguageModel(guardrails: .default)// assess the large language model check AI availablility
    private var session = LanguageModelSession()
    
    @State private var response: String = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            switch largeLanguageModel.availability {
            case .available:
                if response.isEmpty {
                    if isLoading{
                        ProgressView()
                    } else {
                        Text("Tap button to get fun response")
                            .foregroundStyle(.tertiary)
                            .multilineTextAlignment(.center)
                            .font(.title)
                    }
                } else {
                    Text(response)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .bold()
                }
            case .unavailable(.deviceNotEligible):
                Text("your device isn't eligible for Apple Intelligence")
            case .unavailable(.appleIntelligenceNotEnabled):
                Text("Please enable Apple Intelligence in settings")
            case .unavailable(.modelNotReady):
                Text("The AI model is not ready")
            case .unavailable(_):
                Text("The AI feature is unavailable for an unknown reason")
            }
            
            Spacer()
            
            Button {
                Task { // asynchronous action
                    isLoading = true // sets @State flag allowing loading indicator to be displayed
                    defer { isLoading = false } // will set back to false when scope of task closure exits
                    let prompt = "Say Hello in a fun way."
                    do {
                        let replay = try await session.respond(to: prompt)
                        response = replay.content
                    } catch {
                        response = "Failed to get response: \(error.localizedDescription)"
                    }
                }
            }label: {
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .glassEffect(.regular.interactive())
        }
        .padding()
        .tint(.blue)
    }
}

#Preview {
    ContentView()
}
