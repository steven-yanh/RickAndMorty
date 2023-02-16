//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func shouldShowCharacterDetail(_ character: RMCharacter)
}

final class RMCharacterListView: UIView {
    
    //MARK: - Logic Component
    private let viewModel = RMCharacterListViewViewModel()
    
    weak var delegate: RMCharacterListViewDelegate?
    
    //MARK: - UI Component
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterListCell.self, forCellWithReuseIdentifier: RMCharacterListCell.cellIdentifier)
        collectionView.register(RMFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        collectionView.alpha = 0
        return collectionView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layout()
        spinner.startAnimating()
        viewModel.delegate = self
        setupCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    //MARK: - Private
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

//MARK: - RMCharacterListViewViewModelDelegate
extension RMCharacterListView: RMCharacterListViewViewModelDelegate {
    func didFetchMoreCharacters(with indexPaths: [IndexPath]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.collectionView.performBatchUpdates {
                self.collectionView.insertItems(at: indexPaths)
            }
        }
    }
    
    func didSelectCharacer(_ character: RMCharacter) {
        delegate?.shouldShowCharacterDetail(character)
    }
    
    func didFetchInitalCharacters() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()
            
            UIView.animate(withDuration: 0.5) {
                self?.collectionView.alpha = 1
            }
        }
    }
}

//MARK: - Layout
extension RMCharacterListView {
    private func layout() {
        addSubviews(collectionView, spinner)
        
        collectionView.pin(to: self)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
        ])
        
    }
}
