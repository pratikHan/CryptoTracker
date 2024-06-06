//
//  CoinImageView.swift
//  SwiftfulCrypto
//
//  Created by Pratik Hanchate on 6/3/24.
//

import SwiftUI

struct CoinImageView: View {

    @StateObject var viewModel: CoinImageViewModel

    init(coinModel: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coinModel: coinModel))
    }

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CoinImageView(coinModel: DeveloperPreview.instance.coin)
}
