//
//  CrossfitAPICall.swift
//  Crossfit Games Draft
//
//  Created by Tracey Bernstein on 4/2/26.
//
import Foundation
import SwiftUI

struct ChampionsAPI {
    static let shared = ChampionsAPI()
    static let APIKey = "placeholderfor now"
    static let baseURL = "https://games.crossfit.com/athletes"
    static let individualURL = "individual"
    static let searchChampions = "https://www.crossfit.com/wp-content/uploads/2025/08/20090945/Jayson-Hopper-2025.jpg"
}

    enum APIError: Error {
        case failedToGetData
    }

class ChampionsAPICall: Decodable, Identifiable {
    static let shared = ChampionsAPICall()
    
    func getChampions(completion: @escaping (Result<(ChampionsResponse), Error>) -> Void) {
        guard let url = URL(string: "\(ChampionsAPI.baseURL)/\(ChampionsAPI.championsURL)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let athletes = try JSONDecoder().decode(ChampionsResponse.self, from: data)
                print(athletes)
                completion(.success(athletes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    func getathletesReferenceImageID(completion: @escaping ([ChampionsResponse]) -> Void) {
        guard let url = URL(string: "\(ChampionsAPI.baseURL)/\(ChampionsAPI.searchAthlete)&api_key=\(ChampionsAPI.APIKey)/") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder  = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let athletes = try decoder.decode([ChampionsResponse].self, from: data)
                completion(athletes)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
