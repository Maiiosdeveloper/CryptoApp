//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Mai on 12/08/2024.
//

import Foundation
import Combine
enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL?)
    case unknown
    var errorDescription: String? {
        switch self {
        case .badURLResponse(let url): "[🔥] bad response url: \(String(describing: url))"
        case .unknown: "[⚠️] unknown error"
        }
    }
}
class NetworkingManager {
    static func download(url: URLRequest) -> AnyPublisher<Data, Error>{
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleStatusCode(output: $0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
         
    }
    static func handleStatusCode(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        
        /* check if response if good data or not
         check also if the httpresponse has a status ccode
         */
        guard let response = output.response as? HTTPURLResponse,  response.statusCode >= 200 && response.statusCode < 300 else{
            throw NetworkingError.badURLResponse(url: output.response.url)
        }
        return output.data
    }
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
            print(String(describing: error))
        }
    }
}
