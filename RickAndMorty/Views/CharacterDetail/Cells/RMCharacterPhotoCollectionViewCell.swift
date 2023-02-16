//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Huang Yan on 2/16/23.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func style() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.shadowColor = UIColor.systemGray2.cgColor
        contentView.layer.shadowOpacity = 0.7
        contentView.layer.shadowOffset = CGSize(width: -5, height: 7)
        contentView.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
    }
    
    //MARK: - layout
    private func layout() {
        contentView.addSubviews(imageView)
        imageView.pin(to: contentView)
    }
    
    //MARK: - Public
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
