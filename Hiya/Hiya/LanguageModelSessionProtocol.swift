//
//  LanguageModelSessionProtocol.swift
//  Hiya
//
//  Created by Tracey Bernstein on 5/3/26.
//
import FoundationModels

protocol LanguageModelSessionProtocol {
    func respond(to prompt: String) async throws -> String
}

