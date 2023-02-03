//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Huang Yan on 2/2/23.
//

import UIKit

final class RMImageLoader {
    
    private var cache = NSCache<NSString, NSData>()
    
    static let shared = RMImageLoader()
    
    private init() {}
    
    public func downloadImage(_ url: URL?, completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let key = url.absoluteString as NSString
        // Accesing cache if image already exist
        if let data = cache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        
        // Fetch image thourgh network
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
                self?.cache.setObject(data as NSData, forKey: key)
                completion(.success(data))
            
        }.resume()
    }
}
