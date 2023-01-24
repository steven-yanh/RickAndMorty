//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/22/23.
//

import Foundation
struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharaterGender
    let origin: RMCharacterOrigin
    let location: RMCharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    struct RMCharacterOrigin: Codable {
        let name: String
        let url: String
    }
    struct RMCharacterLocation: Codable {
        let name: String
        let url: String
    }
}

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}

enum RMCharaterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}
