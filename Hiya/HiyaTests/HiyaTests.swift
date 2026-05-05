//
//  HiyaTests.swift
//  HiyaTests
//
//  Created by Tracey Bernstein on 5/3/26.
//

import Testing
import XCTest
import FoundationModels


@testable import Hiya

struct HiyaTests: LanguageModelSessionProtocol {
    func respond(to prompt: String) async throws -> String {
        <#code#>
    }
    
    
    
    // control what respond() returns
    var stubbedResponse: String = "Hello, Universe!"
    
    // simulate failure
    var stubbedError: Error? = nil
    
    func respond(to prompt: String) async throws -> LanguageModelSessionProtocol {
        if let error = stubbedError {
            throw error
        }
        return stubbedResponse as! LanguageModelSessionProtocol
    }
}
final class ContentViewTests: XCTestCase {
    // happy path session returns response
    
    func testRespondReturnsExpectedString() async throws {
        
        let mock = HiyaTests(stubbedResponse: "Heloooooo !")
        let result = try await mock.respond(to: "Say hello in a fun way. ")
        XCTAssert(result, "Helloooooo !")
    }
    
    func testRespondHandlesError() async throws {
        struct FakeError: Error, LocalizedError {
            var errorDescription: String? {
                "Network unavailable"
            }
            var mock = HiyaTests()
            mock.stubbedError = FakeError()
            
            do {
                _ = try await mock.respond(to: "Say hello in a fun way. ")
                XCTFail("expected error to be thrown")
            } catch {
                XCTAssertEqual(error.localizedDescription, "Network unavailable")
            }
        }
    }

}
