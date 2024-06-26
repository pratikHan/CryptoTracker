//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Pratik Hanchate on 6/3/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil
    var imageSubscription: AnyCancellable?
    var coin: CoinModel

    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String


    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }


    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            print("Retrieving from file Manager")
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }

    private func downloadCoinImage() {
        print("Downloading images")
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleSubs(completion:), receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: folderName)
            })
    }
}
