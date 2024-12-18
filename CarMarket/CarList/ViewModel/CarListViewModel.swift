//
//  CarListViewModel.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//

import Foundation

final class CarListViewModel: ObservableObject {

    enum Constant {
        static let noCars = "There are no cars"
        static let invalidStatusCodeError = "Error: invalidStatusCode"
        static let failedToDecodeError = "Error: failedToDecode"
        static let unknownError = "Error: something went wrong"
    }

    @MainActor @Published var errorMessage: String?
    @MainActor @Published var cars: [CarItem] = []

    private let carService: CarService

    init(carService: CarService) {
        self.carService = carService
    }

    func loadCars() async {
        do {
            let foundCars = try await carService.fetchCars()
            await MainActor.run {
                cars = foundCars.map { .init(with: $0) }
            }
        } catch {
            await MainActor.run {
                errorMessage = handle(error: error)
            }
        }
    }

    private func handle(error: Error) -> String {
            switch error {
            case CarServiceError.empty:
                return Constant.noCars
            case CarServiceError.invalidStatusCode:
                return Constant.invalidStatusCodeError
            case CarServiceError.failedToDecode:
                return Constant.failedToDecodeError
            default:
                return Constant.unknownError
            }
    }
}
