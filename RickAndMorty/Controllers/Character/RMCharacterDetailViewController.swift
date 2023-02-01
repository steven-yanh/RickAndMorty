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
    
    //MARK: - Init
    init(charater: RMCharacter) {
        self.character = charater
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Private
    private func setup() {
        view.backgroundColor = .systemBackground
        title = character.name
        navigationItem.largeTitleDisplayMode = .never
    }
}
