//
//  RecipeCell.swift
//  SushiHub
//
//  Created by Babayev Kamran on 30.06.23.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    static let identifier = "RecipeCell"
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.layer.cornerRadius = 10
        label.mask?.layer.cornerRadius = 10
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        
        // Add constraints
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Add padding from left
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), // Add padding from right
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8), // Add padding from bottom
            titleLabel.heightAnchor.constraint(equalToConstant: 40) // Increase the height of the title label
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        recipeImageView.image = recipe.image
        
        titleLabel.text = recipe.title
    }
}
