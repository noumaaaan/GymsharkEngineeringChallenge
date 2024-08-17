//
//  ProductSortView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    static let checkmark: String = "checkmark"
    static let sortIcon: String = "arrow.up.arrow.down.circle"
}

struct ProductSortView: View {
    let selectedSortOption: SortOption?
    var action: (SortOption) -> Void
    
    var body: some View {
        Menu {
            ForEach(SortOption.allCases, id: \.self) { option in
                Button {
                    action(option)
                } label: {
                    HStack {
                        Text(option.label)
                        Spacer()
                        if let selected = selectedSortOption {
                            if option == selected {
                                Image(systemName: Constants.checkmark)
                            }
                        }
                    }
                }
            }
         } label: {
             Image(systemName: selectedSortOption?.image ?? Constants.sortIcon )
        }
         .contentTransition(.symbolEffect(.replace))
    }
}

#Preview {
    ProductSortView(selectedSortOption: .priceAscending) { option in
    }
}
