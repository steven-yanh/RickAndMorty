//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Huang Yan on 2/15/23.
//

import UIKit
final class RMCharacterDetailView: UIView {
    
    private var collectionView: UICollectionView?
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    init(frame: CGRect, character: RMCharacter) {
        self.viewModel = RMCharacterDetailViewViewModel(character: character)
        super.init(frame: frame)
        collectionView = createCollectionView()
        setupCollectionView()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Private
    private func setupCollectionView() {
        guard let collectionView = collectionView else {
            return
        }
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func layout() {
        guard let collectionView = collectionView else {
            return
        }
        addSubviews(collectionView)
        collectionView.pin(to: self)
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterPhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)
        return collectionView
    }
    
    private func createSection(for index: Int) -> NSCollectionLayoutSection {
        switch index {
        case 0:
            return viewModel.createPhotoSection()
        case 1:
            return viewModel.createInfoSection()
        case 2:
            return viewModel.createEpisodeSection()
        default:
            fatalError("Unexpected Section")
        }
    }
}
