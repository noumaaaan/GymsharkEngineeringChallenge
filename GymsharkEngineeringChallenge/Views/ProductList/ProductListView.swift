//
//  ProductListView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    static let gymsharkHeader: String = "fullgslogo"
    static let gymsharkHeaderWidth: CGFloat = 100
    static let collectionViewHorizontalPadding: CGFloat = 10
}

struct ProductListView: View {
    @StateObject var viewModel = ProductListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                content
                    .padding(.horizontal, Constants.collectionViewHorizontalPadding)
            }
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                viewModel.refreshList()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    gymsharkHeader
                }
                ToolbarItem(placement: .topBarTrailing) {
                    sortingMenu
                }
            }
        }
    }
}

extension ProductListView {
    var content: some View {
        Group {
            switch viewModel.loadingState {
            case .uninitialized, .loading, .emptyLoaded:
                LoadingView()
            case .failure(let error):
                ErrorView(errorMessage: error.localizedDescription) { viewModel.refreshList() }
            case .loaded:
                collectionView
            }
        }
    }
    
    var gymsharkHeader: some View {
        Image(Constants.gymsharkHeader)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: Constants.gymsharkHeaderWidth)
            .foregroundStyle(.accent)
    }
    
    var collectionView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.products) { product in
                    NavigationLink {
                        ProductDetailsView(product: product)
                    } label: {
                        ProductItemView(product: product, imageEndpoint: product.optimisedFeatureMediaURL)
                    }
                }
            }
        }
    }
    
    var sortingMenu: some View {
        ProductSortView(selectedSortOption: viewModel.selectedSortOption) { option in
            viewModel.sortResults(sortOption: option)
        }
        .hidden(!viewModel.sortingMenuShown)
    }
}

#Preview {
    ProductListView()
}
