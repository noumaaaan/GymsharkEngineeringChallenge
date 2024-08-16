//
//  ProductListView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    enum Images {
        static let gymsharkHeader: String = "fullgslogo"
    }
}

struct ProductListView: View {
    
    @StateObject var viewModel = ProductListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                collectionView
                
                if viewModel.showAlert {
                    alertView(message: viewModel.error?.localizedDescription ?? "")
                }
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
            .onReceive(viewModel.$error) { error in
                viewModel.toggleAlert(error: error)
            }
        }
    }
}

extension ProductListView {
    var gymsharkHeader: some View {
        Image(Constants.Images.gymsharkHeader)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100)
            .foregroundStyle(Color.init(hex: "B51B75"))
    }
    
    var collectionView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.products, id: \.self) { product in
                    NavigationLink {
                        ProductDetailsView(product: product)
                        
                    } label: {
                        ProductItemView(
                            product: product,
                            imageEndpoint: product.optimisedFeatureMediaURL
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
        .hidden(viewModel.sortingMenuShown)
    }
    
    func alertView(message: String) -> some View {
        VStack {
            Text("Something went wrong")
                .font(.title3.bold())
                .padding(5)
            
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(3, reservesSpace: true)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button {
                viewModel.refreshList()
            } label: {
                Text("Retry")
                    .font(.title3)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .overlay(alignment: .topTrailing) {
            Button {
                viewModel.showAlert.toggle()
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black.opacity(0.18), lineWidth: 2)
        )
        .padding()
        .transition(
            .opacity.combined(with: .scale)
            .animation(.bouncy(duration: 0.3, extraBounce: 0.2))
        )
    }
    
}

#Preview {
    ProductListView()
}

