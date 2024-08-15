//
//  ProductSortView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

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
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
         } label: {
             Image(systemName: selectedSortOption?.image ?? "arrow.up.arrow.down.circle")
        }
    }
}

#Preview {
    ProductSortView(selectedSortOption: .priceAscending) { option in
    }
}
