//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didFetchInitalCharacters()
    func didFetchMoreCharacters(with indexPaths: [IndexPath])
    
    func didSelectCharacer(_ character: RMCharacter)
}

final class RMCharacterListViewViewModel: NSObject,
                                          UICollectionViewDataSource,
                                          UICollectionViewDelegate,
                                          UICollectionViewDelegateFlowLayout {
    
    private var info: RMCharacterListInfo?
    private var characters: [RMCharacter] = [] {
        didSet {
            cellViewModels = characters.map({
                return RMCharacterListCellViewModel($0.name, $0.status, URL(string: $0.image))
            })
//            for character in characters {
//                let viewModel = RMCharacterListCellViewModel(character.name, character.status, URL(string: character.image))
//                cellViewModels.append(viewModel)
//            }
        }
    }
    private var cellViewModels: [RMCharacterListCellViewModel] = []
    
    private var nextUrl: String? {
        info?.next
    }
    
    weak var delegate: RMCharacterListViewViewModelDelegate?
    
    var moreToLoad: Bool {
        return info?.next != nil
    }
    
    var isLoading = false
    
    override init() {
        super.init()
        fetchInitalCharacters()
    }
    
    //MARK: - Private
    private func fetchInitalCharacters() {
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
    
    private func fetchMoreCharacters(url: URL) {
        
        guard let request = RMRequest(url: url) else {
            isLoading = false
            return
        }
        RMService.shared.execute(request, expecting: RMCharacterList.self) { [weak self] result in
            guard let self = self else {
                self?.isLoading = false
                return
            }
            switch result {
            case .success(let result):
                self.info = result.info
                let originalCount = self.characters.count
                let newCount = result.results.count
                let startingIndex = originalCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                self.characters.append(contentsOf: result.results)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isLoading = false
                }
                
                self.delegate?.didFetchMoreCharacters(with: indexPathToAdd)
                print(self.cellViewModels.count)
            case.failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    //MARK: - Protocol implementation
    //MARK: - DataSource
    /// DataSource for the Cell
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
    
    /// DataSource for the footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,
              moreToLoad,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath) as? RMFooterLoadingCollectionReusableView
        else {
            fatalError("Unexpected to deque a defualt footer view")
        }
        
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard moreToLoad else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    //MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        delegate?.didSelectCharacer(character)
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    //MARK: - CollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (K.screenWidth - 30) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    //MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard moreToLoad, !isLoading, !cellViewModels.isEmpty, let nextUrl = nextUrl, let url = URL(string: nextUrl) else {
            return
        }
        let offset = scrollView.contentOffset.y
        let contentSiezeHeight = scrollView.contentSize.height
        let ScrollViewFixedHeight = scrollView.frame.size.height
        if offset >= (contentSiezeHeight - ScrollViewFixedHeight - 120) {
            isLoading = true
            fetchMoreCharacters(url: url)
        }
        
    }
}
