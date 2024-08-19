//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Mai on 13/08/2024.
//

import Foundation
import Combine
import SwiftUI
class CoinImageService {
    private let folderName = "coins"
    private let id: String
    var imageSubscribtion: AnyCancellable?
    @Published var image: UIImage? {
        didSet {
            guard let img = image else { return }
            LocalFileManager.shared.saveImage(image: img, imageName: id, folderName: folderName)
        }
    }
    init(id: String) {
        self.id = id
        getCoinImage()
    }
    private func getCoinImage() {
        guard let img = LocalFileManager.shared.getImage(imageName: id, folderName: folderName) else {
            downloadImage()
            print("[⚠️] download image: \(id) now")
            return
        }
        self.image = img
        print("[⚠️] Retrieve image from file manager")
    }
    private func downloadImage() {
        guard let url = URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/\(id).png") else { return }
        imageSubscribtion = NetworkingManager.download(url: .init(url: url))
            .tryMap({ data -> UIImage? in
                UIImage(data: data)
            }).sink(receiveCompletion: { NetworkingManager.handleCompletion(completion: $0)
            }, receiveValue: { [weak self] in
                guard let self else { return }
                image = $0
                imageSubscribtion?.cancel()
            })
    }
}
