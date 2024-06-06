//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Pratik Hanchate on 5/25/24.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {

    @StateObject private var viewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .navigationBarTitleDisplayMode(.automatic)
            }.environmentObject(viewModel)
        }
    }
}
