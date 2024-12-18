//
//  APIModels.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//

import Foundation
enum Response {
    struct Car: Codable {
        let id: Int
        let make, model: String
        let price: Int
        let firstRegistration: String?
        let mileage: Int
        let fuel: String
        let images: [Image]?
        let description: String
        let modelline: String?
        let seller: Seller?
        let colour: String?
    }

    struct Image: Codable {
        let url: String
    }

    struct Seller: Codable {
        let type: String
        let phone: String
        let city: String
    }
}
