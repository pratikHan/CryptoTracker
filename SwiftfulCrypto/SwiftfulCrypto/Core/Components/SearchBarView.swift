//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Pratik Hanchate on 6/5/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String


    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.theme.secondaryText)
            TextField("Search by name", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,
                    alignment: .trailing
                )
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15),radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        )
        .padding()

    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.light)
}
