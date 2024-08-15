//
//  ProductListView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = ProductListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                collectionView
            }
            .navigationTitle("Products")
            .toolbarTitleDisplayMode(.inlineLarge)
            .task {
                await viewModel.fetchProducts()
            }
            .refreshable {
                await viewModel.refreshList()
            }
        }
    }
}

extension ProductListView {
    var collectionView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.products, id: \.self) { product in
                    NavigationLink {
                        ProductDetailsView(product: product)
                        
                    } label: {
                        ProductItemView(
                            product: product,
                            imageEndpoint: viewModel.optimiseImageEndpoint(endpoint: product.featuredMedia?.src)
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
}

#Preview {
    ProductListView()
}
