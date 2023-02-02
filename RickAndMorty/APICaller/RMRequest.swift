//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/27/23.
//

import Foundation

final class RMRequest {
    
    struct K {
        static let baseUrl = "https://rickandmortyapi.com/api/"
    }
    
    private let endpoint: RMEndpoint
    
    private let paths: [String]
    
    private let queryParameters: [URLQueryItem]
    
    var urlString: String {
        var urlString = K.baseUrl + endpoint.rawValue
        
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
    
    //MARK: - Inititalizer
    public init(endpoint: RMEndpoint, paths: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.paths = paths
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(K.baseUrl) {
           return nil
        }
        
        let trimmed = string.replacingOccurrences(of: K.baseUrl, with: "")
        if trimmed.contains("/") {
            var components = trimmed.components(separatedBy: "/")
            if !components.isEmpty, let endpoint = RMEndpoint(rawValue: components[0]) {
                components.removeFirst()
                if !components.isEmpty && components[0].contains("=") {
                    let queryItemStrings = components[0].components(separatedBy: "&")
                    var queryItems = [URLQueryItem]()
                    for queryItemString in queryItemStrings {
                        let traits = queryItemString.components(separatedBy: "=")
                        queryItems.append(URLQueryItem(name: traits[0], value: traits[1]))
                    }
                    self.init(endpoint: endpoint, queryParameters: queryItems)
                    return
                } else if !components.isEmpty  { //paths
                    let pathString = components[0]
                    let paths = pathString.components(separatedBy: ",")
                    self.init(endpoint: endpoint, paths: paths)
                    return
                }
                self.init(endpoint: endpoint)
                return
            }
        } else if trimmed.contains("?") {
            var components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, let endpoint = RMEndpoint(rawValue: components[0]) {
                components.removeFirst()
                if !components.isEmpty {
                    let queryItemStrings = components[0].components(separatedBy: "&")
                    var queryItems = [URLQueryItem]()
                    for queryItemString in queryItemStrings {
                        let traits = queryItemString.components(separatedBy: "=")
                        queryItems.append(URLQueryItem(name: traits[0], value: traits[1]))
                    }
                    self.init(endpoint: endpoint, queryParameters: queryItems)
                    return
                }
                self.init(endpoint: endpoint)
                return
            }
        }
        
        return nil
    }
    
    //MARK: - Quick request
    static let allCharacters = RMRequest(endpoint: .character)
    
    static let allLocations = RMRequest(endpoint: .location)
    
    static let allEpisodes = RMRequest(endpoint: .episode)
    
}
