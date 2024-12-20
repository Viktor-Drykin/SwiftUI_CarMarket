//
//  FeatureFactory.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//


import SwiftUI

enum FeatureFactory {
    
    static func carsFeature() -> some View {
        let apiService = APIClient()
        let carService = CarServiceImpl(apiService: apiService)
        let viewModel = CarListViewModel(carService: carService)
        let view = CarListView(viewModel: viewModel)
        return view
    }
}
