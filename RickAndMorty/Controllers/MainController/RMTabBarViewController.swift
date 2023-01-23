//
//  RMTabBarViewController.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/22/23.
//

import UIKit

final class RMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Private
    private func setupViewController() {
        let characterVC = RMCharacterViewController()
        let locationVC = RMLocationViewController()
        let episodeVC = RMEpisodeViewController()
        let settingVC = RMSettingViewController()
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let characterNC = UINavigationController(rootViewController: characterVC)
        let locationNC = UINavigationController(rootViewController: locationVC)
        let episodeNC = UINavigationController(rootViewController: episodeVC)
        let settingNC = UINavigationController(rootViewController: settingVC)
        
        characterNC.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 1)
        locationNC.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "globe"), tag: 2)
        episodeNC.tabBarItem = UITabBarItem(title: "Episode", image: UIImage(systemName: "tv"), tag: 3)
        settingNC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 4)
        
        let controllers = [characterNC, locationNC, episodeNC, settingNC]
        
        for nav in controllers {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        viewControllers = controllers
        
        tabBar.backgroundColor = .systemBackground
        
    }

}
