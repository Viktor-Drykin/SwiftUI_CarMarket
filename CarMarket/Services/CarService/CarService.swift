//
//  CarService.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//


protocol CarService: AnyObject {
    func fetchCars() async throws -> [Response.Car]
}
