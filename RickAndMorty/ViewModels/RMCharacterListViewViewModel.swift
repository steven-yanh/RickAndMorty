//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import UIKit

final class RMCharacterListViewViewModel: NSObject,
                                          UICollectionViewDataSource,
                                          UICollectionViewDelegate,
                                          UICollectionViewDelegateFlowLayout {
    var characters = [RMCharacter]()
    
    override init() {
        super.init()
        fetchCharacters()
    }
    
    //MARK: - Private
    
    private func fetchCharacters() {
        RMService.shared.execute(.allCharacters, expecting: RMCharacterList.self) { result in
            switch result {
            case .success(let result):
                self.characters = result.results
            case.failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    //MARK: - Protocol implementation
    
    //MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterListCell.cellIdentifier, for: indexPath) as? RMCharacterListCell else {
            return UICollectionViewCell()
        }
        let viewModel = RMCharacterListCellViewModel("Steven", .alive, URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"))
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    //MARK: - CollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (K.screenWidth - 30) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
