//
//  SearchBar.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 17/02/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? .dcSecondaryText : .accent
                )
            
            TextField("Search by name or symbol", text: $searchText)
                .foregroundColor(.accent)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .padding()
                        .offset(x: 12)
                        .foregroundColor(.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            self.hideKeyboard()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        } // HStack
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.dcBackground)
                .shadow(color: .accent.opacity(0.5), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

// MARK: - Previews
#Preview("Light",traits: .sizeThatFitsLayout) {
    @State var searchtext = "Bitcoin"
    return SearchBar(searchText: $searchtext)
}

#Preview("Dark",traits: .sizeThatFitsLayout) {
    @State var searchtext = "Bitcoin"
    return SearchBar(searchText: $searchtext)
        .preferredColorScheme(.dark)
}
