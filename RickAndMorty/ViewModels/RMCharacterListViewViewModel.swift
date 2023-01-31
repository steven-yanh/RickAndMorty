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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (K.screenWidth - 30) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
