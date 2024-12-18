//
//  CarServiceError.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//

enum CarServiceError: Error {
    case incorrectURL
    case invalidStatusCode
    case failedToDecode
    case empty
}
