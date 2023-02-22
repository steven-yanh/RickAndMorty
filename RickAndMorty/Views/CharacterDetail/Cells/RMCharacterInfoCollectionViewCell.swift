//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Huang Yan on 2/16/23.
//

import UIKit

class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: K.defaultFontSize+4, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: K.defaultFontSize+8, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        valueLabel.textColor = nil
        titleLabel.text = nil
        titleLabel.textColor = nil
        imageView.image = nil
        imageView.tintColor = nil
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        valueLabel.text = viewModel.valueString
        valueLabel.textColor = viewModel.tintColor
        titleLabel.text = viewModel.titleString
        titleLabel.textColor = viewModel.tintColor
        imageView.image = viewModel.image
        imageView.tintColor = viewModel.tintColor
    }
    //MARK: - Layout
    private func layout() {
        layer.cornerRadius = 10
        backgroundColor = .systemGray4
        
        
        contentView.addSubviews(valueLabel, titleLabel, imageView)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 35),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            valueLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
        ])
    }
}
