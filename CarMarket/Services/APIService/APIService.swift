//
//  APIService.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//


import Foundation

protocol APIService {
    func perform<Output: Decodable>(urlRequest: URLRequest) async throws -> Output
}
