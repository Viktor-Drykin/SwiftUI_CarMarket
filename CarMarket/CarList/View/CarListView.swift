//
//  CarListView.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//

import SwiftUI

struct CarListView: View {

    @ObservedObject var viewModel: CarListViewModel

    init(viewModel: CarListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(viewModel.cars) { item in
                        Text(item.description)
                    }
                }
            }
            .refreshable {
                await viewModel.loadCars()
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .task {
            await viewModel.loadCars()
        }
    }
}

#Preview {
    let apiService = APIClient()
    let carService = CarServiceImpl(apiService: apiService)
    let viewModel = CarListViewModel(carService: carService)
    let view = CarListView(viewModel: viewModel)
    return view
}
