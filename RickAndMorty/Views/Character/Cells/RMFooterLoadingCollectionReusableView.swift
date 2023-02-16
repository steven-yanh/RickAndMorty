//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Huang Yan on 2/1/23.
//

import UIKit

class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    //MARK: - UI
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Public
    public func startAnimating() {
        spinner.startAnimating()
    }
    
    
    //MARK: - layout
    private func layout() {
        addSubviews(spinner)
        
        spinner.centerX(to: self)
        spinner.centerY(to: self)
    }
}
