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
            ZStack {
                VStack(spacing: .zero) {
                    collectionView
                }
                .navigationBarTitleDisplayMode(.inline)
                .refreshable {
                    await viewModel.refreshList()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("fullgslogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .foregroundStyle(Color.init(hex: "B51B75"))
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        sortingMenu
                    }
                }
                
                if viewModel.error != nil {
                    alertView
                }
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
    
    var sortingMenu: some View {
        ProductSortView(selectedSortOption: viewModel.selectedSortOption) { option in
            viewModel.sortResults(sortOption: option)
        }
    }
    
    var alertView: some View {
        CustomAlertView(
            title: "Error",
            message: viewModel.error?.localizedDescription ?? "",
            buttonTitle: "Try again"
        ) {
        } dismissAction: {
            viewModel.isAlertPresented.toggle()
        }
        .transition(
            .opacity.combined(with: .scale)
            .animation(.bouncy(duration: 0.2, extraBounce: 0.3))
        )
    }
    
}

#Preview {
    ProductListView()
}
