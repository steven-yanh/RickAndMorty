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
        view.backgroundColor = .systemBackground
        title = "Character"
        let rmRequest = RMRequest(endpoint: .character, paths: ["1"])
        RMService.shared.execute(rmRequest, expecting: RMCharacter.self) { result in
            switch result {
            case .success(let character):
                print(character.image)
                break
            case.failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        layout()
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
