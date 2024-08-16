//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Mai on 15/08/2024.
//

import SwiftUI
import Combine
class CoinImageViewModel: ObservableObject {
    private let id: String
    @Published var image: UIImage? = nil {
        didSet {
            isLoadinng = image == nil
        }
    }
    @Published var isLoadinng: Bool = false
    private let service: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    init(id: String) {
        self.id = id
        service = .init(id: id)
        service.$image.sink { [weak self] selectedImage in
            guard let self else { return }
            image = selectedImage
        }.store(in: &cancellables)
        
    }
    
}
