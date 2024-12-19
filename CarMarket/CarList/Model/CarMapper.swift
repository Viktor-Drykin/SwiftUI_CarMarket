//
//  CarMapper.swift
//  CarMarket
//
//  Created by Viktor Drykin on 19.12.2024.
//
import Foundation

enum CarMapper {

    private enum Constant {
        static let priceFallback = "Check the price with owner"
    }

    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = "EUR"
        formatter.currencySymbol = "€"
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .currency
        return formatter
    }()

    private static let monthAndYearDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter
    }()

    private static let apiDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-yyyy"
        return dateFormatter
    }()

    static func map(response: [Response.Car]) -> [CarItem] {
        response.map { carDTO in
                .init(
                    id: carDTO.id,
                    model: carDTO.make + carDTO.model,
                    price: currencyFormatter.string(from: NSNumber(value: carDTO.price)) ?? Constant.priceFallback,
                    firstRegistration: map(firstResignation: carDTO.firstRegistration),
                    mileage: carDTO.mileage,
                    fuel: carDTO.fuel,
                    images: carDTO.images?.map { $0.url } ?? [],
                    description: carDTO.description,
                    modelline: carDTO.modelline,
                    seller: carDTO.seller.flatMap {
                        .init(type: $0.type,
                              phone: $0.phone,
                              city: $0.city)
                    },
                    colour: carDTO.colour
                )
        }
    }

    static private func map(firstResignation: String?) -> String? {
        guard
            let firstResignation = firstResignation,
            let date = apiDateFormatter.date(from: firstResignation)
        else {
            return nil
        }
        return monthAndYearDateFormatter.string(from: date)
    }
}
