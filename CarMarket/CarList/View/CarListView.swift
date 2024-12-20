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
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    init(viewModel: CarListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            ScrollView {
                GeometryReader { proxy in
                    LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                        ForEach(viewModel.cars) { item in
                            Button {
                                selectedCarItem = item
                                showingDetails.toggle()
                            } label: {
                                makeCarItemView(width: (proxy.size.width - 30) / 2, item: item)
                            }
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

    private func makeCarItemView(width: CGFloat, item: CarItem) -> some View {
        ImageView(urlString: item.images.first?.url)
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: 300)
            .clipped()
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.model)
                        .font(.title2)
                    Text(item.price)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .foregroundStyle(.white)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(colors: [Color.black.opacity(0.8).opacity(0.1), Color.black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                )
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
