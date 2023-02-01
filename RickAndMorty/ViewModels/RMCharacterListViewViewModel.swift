//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didFetchInitalCharacters()
}

final class RMCharacterListViewViewModel: NSObject,
                                          UICollectionViewDataSource,
                                          UICollectionViewDelegate,
                                          UICollectionViewDelegateFlowLayout {
    private var info: RMCharacterListInfo?
    private var characters: [RMCharacter] = [] {
        didSet {
            let viewModels = characters.map({
                return RMCharacterListCellViewModel($0.name, $0.status, URL(string: $0.image))
            })
            cellViewModels.append(contentsOf: viewModels)
        }
    }
    private var cellViewModels: [RMCharacterListCellViewModel] = []
    
    weak var delegate: RMCharacterListViewViewModelDelegate?
    
    override init() {
        super.init()
        fetchCharacters()
    }
    
    //MARK: - Private
    
    private func fetchCharacters() {
        RMService.shared.execute(.allCharacters, expecting: RMCharacterList.self) { [weak self] result in
            switch result {
            case .success(let result):
                self?.info = result.info
                self?.characters = result.results
                self?.delegate?.didFetchInitalCharacters()
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
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
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
