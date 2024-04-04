//
//  APIService.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 03/03/2024.
//

import Foundation
import Combine

public class APIService {
    private init(){} 
    public static let shared = APIService()
    var cancellables = Set<AnyCancellable>()
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<T: Decodable>(urlString: String,  completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let decoder = JSONDecoder()
        let request = URLRequest(url: url)
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { (taskCompletion) in
                switch taskCompletion {
                case .finished:
                    return
                case .failure(let decodingError):
                    completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                }
                
            } receiveValue: { (decodedData) in
                completion(.success(decodedData))
            }
            .store(in: &cancellables)
        
        
    }
}

