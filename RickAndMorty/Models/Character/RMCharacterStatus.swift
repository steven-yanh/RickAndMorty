//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/27/23.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    public var text: String {
        switch self {
        case .alive:
            return rawValue
        case .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
