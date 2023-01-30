//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/22/23.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
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
    }
}
