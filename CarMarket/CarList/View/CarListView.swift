//
//  CarListView.swift
//  CarMarket
//
//  Created by Viktor Drykin on 18.12.2024.
//

import SwiftUI

struct CarListView: View {

    @ObservedObject var viewModel: CarListViewModel
    @State private var showingDetails = false
    @State private var selectedCarItem: CarItem?
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    init(viewModel: CarListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                    ForEach(viewModel.cars) { item in
                        Button {
                            selectedCarItem = item
                            showingDetails.toggle()
                        } label: {
                            CarItemView(urlString: item.images.first?.url, model: item.model, price: item.price)
                                .frame(height: 300)
                        }
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
        .sheet(item: $selectedCarItem) { item in
            CarDetailsView(carItem: item)
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
