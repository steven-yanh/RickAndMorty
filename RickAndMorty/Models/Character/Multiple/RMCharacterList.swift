//
//  RMCharacterList.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import Foundation

struct RMCharacterList: Codable {
    let info: RMCharacterListInfo
    let results: [RMCharacter]
}
