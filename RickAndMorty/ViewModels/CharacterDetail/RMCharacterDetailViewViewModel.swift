//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Huang Yan on 2/15/23.
//

import Foundation
import UIKit
final class RMCharacterDetailViewViewModel: NSObject {
    
    private let character: RMCharacter
    
    public var sections: [SectionType] = []
    
    ///associted value
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        
        case info(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        
        case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    init(character: RMCharacter) {
        self.character = character
        super.init()
        
        setupSections()
    }
    
    //MARK: - Create Sections
    private func setupSections() {
        sections = [.photo(viewModel: .init()),
                    .info(viewModels: [RMCharacterInfoCollectionViewCellViewModel(),
                                       RMCharacterInfoCollectionViewCellViewModel(),
                                       RMCharacterInfoCollectionViewCellViewModel(),
                                       RMCharacterInfoCollectionViewCellViewModel(),]),
                    .episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel(),
                                           RMCharacterEpisodeCollectionViewCellViewModel(),
                                           RMCharacterEpisodeCollectionViewCellViewModel(),
                                           RMCharacterEpisodeCollectionViewCellViewModel(),])
            ]
    }
    public func createPhotoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                       heightDimension: .fractionalHeight(0.5)),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                       heightDimension: .absolute(150)),
                                                     subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createEpisodeSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.6),
                                                                       heightDimension: .fractionalHeight(0.2)),
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

//MARK: - DataSource && Delegate
extension RMCharacterDetailViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .info(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let sectionType = sections[section]
        switch sectionType {
        case .photo:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterPhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .purple
            return cell
        case .info:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .yellow
            return cell
        case .episodes:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .blue
            return cell
        }
    }
}
