//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/27/23.
//

import Foundation

final class RMRequest {
    
    private let baseUrl = "https://rickandmortyapi.com/api/"
    
    private let endpoint: RMEndpoint
    
    private let paths: [String]
    
    private let queryParameters: [URLQueryItem]
    
    var urlString: String {
        var urlString = baseUrl + endpoint.rawValue
        
        if !paths.isEmpty {
            let pathString = paths.joined(separator: ",")
            urlString += "/" + pathString
        }
        
        if !queryParameters.isEmpty {
            urlString += "?"
//            my documentation
//            for parameter in queryParameters {
//                urlString += parameter.name + "=" + (parameter.value ?? "") + "&"
//            }
//            urlString.removeLast()
            
//            iOS Academy:
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            urlString += argumentString
        }
        
        return urlString
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    public init(endpoint: RMEndpoint, paths: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.paths = paths
        self.queryParameters = queryParameters
    }
    
    //MARK: - Quick request
    static let allCharacters = RMRequest(endpoint: .character)
    
    static let allLocations = RMRequest(endpoint: .location)
    
    static let allEpisodes = RMRequest(endpoint: .episode)
    
}
