//
//  RMService.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/27/23.
//

import Foundation

class RMService {
    
    static let shared = RMService()
    
    private init() {
        
    }
    
    public func execute <T:Codable> (_ request: RMRequest, expecting: T.Type, completion: @escaping(Result<T,Error>) -> Void) {
        /// Generate URL
        guard let urlRequest = self.urlRequest(from: request) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            /// Validate server response
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            /// Decoding:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(T.self, from: data) else {
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            /// Returning data by calling callback function
            completion(.success(decodedData))
        }.resume()
    }
    
    //MARK: - Private
    private func urlRequest(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = .get
        return urlRequest
    }
    
}
