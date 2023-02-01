//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/22/23.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    
    private lazy var characterListView: RMCharacterListView = {
        let listView = RMCharacterListView()
        listView.translatesAutoresizingMaskIntoConstraints = false
        return listView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    //MARK: - Private
    private func setup() {
        view.backgroundColor = .systemBackground
        title = "Character"
        characterListView.delegate = self
    }
    
    //MARK: - Layout
    private func layout() {
        view.addSubview(characterListView)
        
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - RMCharacterListViewDelegate
extension RMCharacterViewController: RMCharacterListViewDelegate {
    func shouldShowCharacterDetail(_ character: RMCharacter) {
        let detailVC = RMCharacterDetailViewController(charater: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
