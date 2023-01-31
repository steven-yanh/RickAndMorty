//
//  RMCharacterListInfo.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import Foundation
struct RMCharacterListInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
