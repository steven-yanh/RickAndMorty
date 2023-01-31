//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import UIKit

class RMCharacterListView: UIView {
    
    private let viewModel = RMCharacterListViewViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
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
