//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import UIKit

final class RMCharacterListView: UIView {
    
    private let viewModel = RMCharacterListViewViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterListCell.self, forCellWithReuseIdentifier: RMCharacterListCell.cellIdentifier)
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
        setupCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    //MARK: - Private
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.spinner.stopAnimating()
            
            UIView.animate(withDuration: 0.5) {
                self.collectionView.alpha = 1
            }
        }
    }
    
    //MARK: - Layout
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
