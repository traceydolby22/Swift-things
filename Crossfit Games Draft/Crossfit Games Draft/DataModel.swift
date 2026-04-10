//
//  DataModel.swift
//  Crossfit Games Draft
//
//  Created by Tracey Bernstein on 4/2/26.
//
import SwiftUI
internal import Combine
import Foundation

struct ChampionsResponse: Codable {
    let id: String
    let title: String
    let body: String
    enum CodingKeys: String, CodingKey {
        case id, title, body
    }
}

struct Athletes: Codable {
    let name: String
    let division: String
    let score: Int
}

typealias Champions = [ChampionsResponse]

/* struct MockData: Decodable {
 static let sampleAthlete = ChampionsResponse(
    id: 2,
    name: "Tia-Claire Toomey")
 static let athlete = [sampleAthlete, sampleAthlete, sampleAthlete, sampleAthlete,]
 }
 */
