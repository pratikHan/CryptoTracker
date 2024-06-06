//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Pratik Hanchate on 6/1/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        DispatchQueue.main.async {
            self.addSubs()
        }
    }

    func addSubs() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
