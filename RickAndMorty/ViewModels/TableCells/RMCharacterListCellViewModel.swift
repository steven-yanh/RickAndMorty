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
    public let imageUrl: URL?
    private let status: RMCharacterStatus
    
    init(_ name: String, _ status: RMCharacterStatus, _ imageUrl: URL?) {
        self.name = name
        self.status = status
        self.imageUrl = imageUrl
    }
    
    public var statusText: String {
        return status.text
    }
}
