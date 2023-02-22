//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Huang Yan on 2/16/23.
//

import Foundation
import UIKit

final class RMCharacterInfoCollectionViewCellViewModel: NSObject {
    
    static private let dateFormatter: DateFormatter = {
        // format
        // 2017-11-04T18:48:46.250Z
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = .current
        return formatter
    }()
    static private let shortDateFormatter: DateFormatter = {
        // format
        // 2017-11-04T18:48:46.250Z
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    private let type: `Type`
    
    private let value: String
    
    enum `Type` {
        case gender
        case status
        case species
        case type
        case origin
        case location
        case created
        case episodeCount
    }
    
    //MARK: - Public
    public var titleString: String {
        switch type {
        case .gender:
            return "Gender"
        case .status:
            return "Status"
        case .species:
            return "Species"
        case .type:
            return "Type"
        case .origin:
            return "Origin"
        case .location:
            return "Location"
        case .created:
            return "Created"
        case .episodeCount:
            return "Episode Count"
        }
    }
    
    public var valueString: String {
        switch type {
        case    .gender,
                .status,
                .species,
                .origin,
                .location,
                .episodeCount:
            return value
        case .created:
            if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: value) {
                return RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
            }
            return value
        case .type:
            if value.isEmpty {
                return "None"
            }
            return value
        }
    }
    
    public var image: UIImage? {
        switch type {
        case .gender:
            let image = UIImage(systemName: "bell")
            if value == "Male" {
                image?.withTintColor(.systemBlue)
            } else {
                image?.withTintColor(.systemPink)
            }
            return image
        case .status:
            let image = UIImage(systemName: "bell")
            image?.withTintColor(.systemGreen)
            return image
        case .species:
            let image = UIImage(systemName: "bell")
            image?.withTintColor(.systemMint)
            return image
        case .type:
            let image = UIImage(systemName: "bell")
            image?.withTintColor(.systemRed)
            return image
        case .origin:
            let image = UIImage(systemName: "bell")
            image?.withTintColor(.systemFill)
            return image
        case .location:
            let image = UIImage(systemName: "bell")
            image?.withTintColor(.systemPink)
            return image
        case .created:
            let image = UIImage(systemName: "bell")
            image?.withTintColor(.systemPink)
            return image
        case .episodeCount:
            let image = UIImage(systemName: "bell")
            image?.withTintColor(.systemPink)
            return image
        }
    }
    
    public var tintColor: UIColor {
        switch type {
        case .gender:
            if value == "Male" {
                return .systemBlue
            } else {
                return .systemPink
            }
        case .status:
            if value == "Alive" {
                return .green
            } else if value == "Dead" {
                return .gray
            } else {
                return .label
            }
        case .species:
            if value == "Human" {
                return .systemBlue
            } else {
                return .gray
            }
        case .type:
            return .gray
        case .origin:
            return .gray
        case .location:
            return .gray
        case .created:
            return .gray
        case .episodeCount:
            return .gray
        }
    }
    
    //MARK: - Init
    init(type: `Type`, value: String) {
        self.type = type
        self.value = value
    }
    
}
