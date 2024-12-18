//
//  CarItem.swift
//  CarMarket
//
//  Created by DataArt Viktor Drykin on 18.12.2024.
//
import Foundation

//TODO: remove unused properties
struct CarItem: Identifiable {

    struct Seller {
        let type: String
        let phone: String
        let city: String
    }

    let id: Int
    let make: String
    let model: String
    let price: Int
    let firstRegistration: String?
    let mileage: Int
    let fuel: String
    let images: [String]?
    let description: String
    let modelline: String?
    let seller: Seller?
    let colour: String?
}

extension CarItem {
    init(with carDTO: Response.Car) {
        self.init(
            id: carDTO.id,
            make: carDTO.make,
            model: carDTO.model,
            price: carDTO.price,
            firstRegistration: carDTO.firstRegistration,
            mileage: carDTO.mileage,
            fuel: carDTO.fuel,
            images: carDTO.images?.map { $0.url
            } ?? [],
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
