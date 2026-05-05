//
//  RealLanguagModelSession.swift
//  Hiya
//
//  Created by Tracey Bernstein on 5/3/26.
//
import FoundationModels

struct RealLanguageModelSession: LanguageModelSessionProtocol {
    private let session = LanguageModelSession()

    func respond(to prompt: String) async throws -> String {
        let reply = try await session.respond(to: prompt)
        return reply.content  // unwrap here, return plain String
    }
}
