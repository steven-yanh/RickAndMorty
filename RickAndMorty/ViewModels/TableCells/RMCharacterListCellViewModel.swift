//
//  RMCharacterListCellViewModel.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/31/23.
//

import Foundation
import UIKit

class RMCharacterListCellViewModel {
    
    public let name: String
    private let status: RMCharacterStatus
    private let imageUrl: URL?
    
    init(_ name: String, _ status: RMCharacterStatus, _ imageUrl: URL?) {
        self.name = name
        self.status = status
        self.imageUrl = imageUrl
    }
    
    public var statusText: String {
        return status.text
    }
    
    public func downloadImage(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        guard let url = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            let image = UIImage(data: data)
            completion(.success(image))
        }.resume()
    }
}
