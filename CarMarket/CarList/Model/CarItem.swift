//
//  CarItem.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//
import Foundation

struct CarItem: Identifiable {

    struct Seller {
        let type: String
        let phone: String
        let city: String
    }

    struct Image: Identifiable {
        let id = UUID().uuidString
        let url: String
    }

    let id: Int
    let model: String
    let price: String
    let firstRegistration: String?
    let mileage: String
    let fuel: String
    let images: [Image]
    let description: String
    let modelline: String?
    let seller: Seller?
    let colour: String?
}
