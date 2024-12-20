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

    static func map(response: [Response.Car]) -> [CarItem] {
        response.map { carDTO in
            let price = Formatter.currency.string(from: NSNumber(value: carDTO.price)) ?? Constant.priceFallback
            let mileage = Formatter.measurement.string(from: Measurement(value: Double(carDTO.mileage), unit: UnitLength.kilometers))
            return .init(
                id: carDTO.id,
                model: "\(carDTO.make) \(carDTO.model)",
                price: price,
                firstRegistration: map(firstResignation: carDTO.firstRegistration),
                mileage: mileage,
                fuel: carDTO.fuel,
                images: carDTO.images?.map { .init(url: $0.url) } ?? [],
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
            let date = Formatter.apiDate.date(from: firstResignation)
        else {
            return nil
        }
        return Formatter.monthAndYearDate.string(from: date)
    }
}
