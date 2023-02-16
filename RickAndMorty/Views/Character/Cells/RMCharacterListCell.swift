//
//  RMCharacterListCell.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/31/23.
//

import UIKit

class RMCharacterListCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterListCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: K.defaultFontSize, weight: .bold)
        return label
    }()
    
    private let status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: K.defaultFontSize - 2, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        name.text = nil
        status.text = nil
    }
    
    public func configure(with viewModel: RMCharacterListCellViewModel) {
        name.text = viewModel.name
        status.text = "Status: \(viewModel.statusText)"
        
        RMImageLoader.shared.downloadImage(viewModel.imageUrl) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Styling
    private func style() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.shadowColor = UIColor.systemGray2.cgColor
        contentView.layer.shadowOpacity = 0.7
        contentView.layer.shadowOffset = CGSize(width: -5, height: 7)
        contentView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner] //top left, top right
        imageView.layer.cornerRadius = 8
    }
    
    //MARK: - Layout
    private func layout() {
        contentView.addSubviews(imageView, name, status)
        
        NSLayoutConstraint.activate([
            status.heightAnchor.constraint(equalToConstant: 30),
            name.heightAnchor.constraint(equalToConstant: 30),
            
            status.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            status.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
//            imageView.bottomAnchor.constraint(equalTo: name.topAnchor),
            
            status.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            name.bottomAnchor.constraint(equalTo: status.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: name.topAnchor),
            
        ])
    }
}
