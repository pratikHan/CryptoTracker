//
//  CoinImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Pratik Hanchate on 6/3/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false

    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellable = Set<AnyCancellable>()

    init(coinModel: CoinModel) {
        self.coin = coinModel
        self.dataService = CoinImageService(coin: coin)
        addSubs()
    }

    private func addSubs() {
        dataService.$image
        .sink(receiveCompletion: { [weak self]_ in
            self?.isLoading = false
        }, receiveValue: { [weak self] resultImage in
            self?.image = resultImage
        })
        .store(in: &cancellable)

    }

}
