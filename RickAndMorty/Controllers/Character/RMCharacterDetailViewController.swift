//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Huang Yan on 2/1/23.
//

import UIKit

class RMCharacterDetailViewController: UIViewController {
    
    //MARK: - Logic Component
    private let character: RMCharacter
    
    //MARK: - UI Component
    private let detailView: RMCharacterDetailView
    
    //MARK: - Init
    init(character: RMCharacter) {
        self.character = character
        self.detailView = RMCharacterDetailView(frame: .zero, character: character)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    //MARK: - Private
    private func setup() {
        view.backgroundColor = .systemBackground
        title = character.name
        navigationItem.largeTitleDisplayMode = .never
    }
    private func layout() {
        view.addSubviews(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
