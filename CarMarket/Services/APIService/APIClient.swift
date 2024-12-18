//
//  APIClient.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//


import Foundation

final class APIClient: APIService {

    func perform<Output: Decodable>(urlRequest: URLRequest) async throws -> Output {

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard
            let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode)
        else {
            throw NetworkError.invalidStatusCode
        }

        do {
            let decodedResult = try JSONDecoder().decode(Output.self, from: data)
            return decodedResult
        } catch {
            throw NetworkError.failedToDecode
        }
    }
}
