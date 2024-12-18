//
//  CarMarketApp.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//

import SwiftUI

@main
struct CarMarketApp: App {

    var body: some Scene {
        WindowGroup {
            FeatureFactory.carsFeature()
        }
    }
}
