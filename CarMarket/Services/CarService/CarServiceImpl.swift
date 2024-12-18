//
//  CarServiceImpl.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//

import Foundation

final class CarServiceImpl {

    private let urlPath = "https://private-fe87c-simpleclassifieds.apiary-mock.com/"
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }
}

extension CarServiceImpl: CarService {

    func fetchCars() async throws -> [Response.Car] {

        guard let url = URL(string: urlPath) else {
            throw CarServiceError.incorrectURL
        }

        let request = URLRequest(url: url)

        do {
            let cars: [Response.Car] = try await apiService.perform(urlRequest: request)
            guard !cars.isEmpty else {
                throw CarServiceError.empty
            }
            return cars
        } catch NetworkError.failedToDecode {
            throw CarServiceError.failedToDecode
        } catch NetworkError.invalidStatusCode {
            throw CarServiceError.invalidStatusCode
        }
    }
}
