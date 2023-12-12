//
//  NetworkManager.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getData<T: Decodable>(endpoint: EndPoint, type: T.Type) async throws -> T
}

enum EndPoint: String {
    case newsFeed = "newsFeed-v1.json"
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private var baseURL = "https://gist.githubusercontent.com/kevmathew/9c07498519525428c67d647dbe34d5a8/raw/6c6df054265a98f274e5df1e850b4cc3327fe9fa/"
    
    func getData<T: Decodable>(endpoint: EndPoint, type: T.Type) async throws -> T {
        
        guard let url = URL(string: self.baseURL.appending(endpoint.rawValue)) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.responseError
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}


