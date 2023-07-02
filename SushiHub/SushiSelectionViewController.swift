//
//  SushiSelectionViewController.swift
//  SushiHub
//
//  Created by Babayev Kamran on 30.06.23.
//

import UIKit

class SushiSelectionViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 230, height: 280)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CoffeeCell.self, forCellWithReuseIdentifier: CoffeeCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .left
        label.text = "Available Sushi Ingredients"
        label.textColor = .white
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Explore a variety of sushi ingredients and know what you need to add to your favourite sushi."
        label.textColor = .gray
        
        return label
    }()
    
    private var coffees: [Sushi] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(descriptionLabel)
        
        // Set up constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            collectionView.heightAnchor.constraint(equalToConstant: 320),
            
            descriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        coffees = [
            Sushi(name: "Maguro", image: UIImage(named: "Maguro")!, instructions: [
                "1. Fresh Maguro (tuna) slices",
                "2. Sushi rice",
                "3. Nori (seaweed) sheets",
                "4. Wasabi paste",
                "5. Soy sauce",
                "6. Pickled ginger (optional)"
            ]),
            Sushi(name: "Sake", image: UIImage(named: "Sake")!, instructions: [
                "1. Fresh Sake (tuna) slices",
                "2. Sushi rice",
                "3. Nori (seaweed) sheets",
                "4. Wasabi paste",
                "5. Soy sauce",
                "6. Pickled ginger (optional)"
            ]),
            Sushi(name: "California", image: UIImage(named: "California")!, instructions: [
                "1. Nori (seaweed) sheets",
                "2. Sushi rice",
                "3. Imitation crab meat or real crab meat (cooked and shredded)",
                "4. Ripe avocado",
                "5. Cucumber",
                "6. Soy sauce",
                "7. Wasabi paste",
                "8. Pickled ginger (optional)"
            ]),
            Sushi(name: "Philadelphia", image: UIImage(named: "Philadelphia")!, instructions: [
                "1. Nori (seaweed) sheets",
                "2. Sushi rice",
                "3. Smoked salmon",
                "4. Cream cheese",
                "5. Cucumber",
                "6. Cut the sushi rolls",
                "7. Soy sauce",
                "8. Wasabi paste",
                "9. Pickled ginger (optional)"
            
            ]),
            Sushi(name: "Uni", image: UIImage(named: "Uni")!, instructions: [
                
                "1. Fresh uni (sea urchin) tongues",
                "2. Sushi rice",
                "3. Nori (seaweed) sheets",
                "4. Wasabi paste (optional)",
                "5. Soy sauce",
                "6. Pickled ginger (optional)"
                
            ]),
            Sushi(name: "Hotate", image: UIImage(named: "Hotate")!, instructions: [
                
                "1. Fresh scallops (sashimi-grade)",
                "2. Sushi rice",
                "3. Nori (seaweed) sheets",
                "4. Wasabi paste",
                "5. Soy sauce",
                "6. Pickled ginger (optional)"
                
            ]),
            Sushi(name: "Spicy Tuna", image: UIImage(named: "Spicy Tuna")!, instructions: [
                
                "1. Sushi-grade tuna",
                "2. Sushi rice",
                "3. Nori (seaweed) sheets",
                "4. Mayonnaise",
                "5. Sriracha sauce (or any other hot sauce)",
                "6. Cut the sushi rolls",
                "7. Soy sauce",
                "8. Wasabi paste",
                "9. Pickled ginger (optional)"

            ]),
            Sushi(name: "Salmon Skin", image: UIImage(named: "Salmon Skin")!, instructions: [
                "1. Salmon skin (from fresh salmon fillets)",
                "2. Sushi rice",
                "3. Nori (seaweed) sheets",
                "4. Soy sauce",
                "5. Wasabi paste",
                "6. Pickled ginger (optional)"
                   
            ]),
            Sushi(name: "Spider", image: UIImage(named: "Spider")!, instructions: [
                "1. Soft shell crab",
                "2. Sushi rice",
                "3. Nori (seaweed) sheets",
                "4. Tempura batter mix",
                "5. Vegetable oil for frying",
                "6. Cut the sushi rolls",
                "7. Soy sauce",
                "8. Wasabi paste",
                "9. Pickled ginger (optional)"
                
            ]),
            Sushi(name: "Volcano", image: UIImage(named: "Volcano")!, instructions: [
                "1. Sushi rice",
                "2. Nori (seaweed) sheets",
                "3. Assorted seafood (such as diced raw tuna, salmon, or shrimp)",
                "4. Spicy mayo (mayonnaise mixed with Sriracha or other hot sauce)",
                "5. Topping ingredients (e.g., masago, tobiko, green onions)",
  
            ]),
            
            Sushi(name: "Tekka Don", image: UIImage(named: "Tekka Don")!, instructions: [
                "1. Sushi-grade tuna (fresh and raw)",
                "2. Sushi rice",
                "3. Soy sauce",
                "4. Wasabi paste",
                "5. Pickled ginger (optional)",
                "6. Sesame seeds (optional)",
                "7. Nori (seaweed) sheets (optional)"
                
            ]),
            Sushi(name: "Unagi Don", image: UIImage(named: "Unagi Don")!, instructions: [
                "1. Unagi (grilled eel)",
                "2. Sushi rice",
                "3. Unagi sauce (store-bought or homemade)",
                "4. Nori (seaweed) sheets (optional)",
                "5. Pickled ginger (optional)",
                
            ])
        ]

        
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension SushiSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoffeeCell.identifier, for: indexPath) as! CoffeeCell
        let coffee = coffees[indexPath.item]
        cell.configure(with: coffee)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coffee = coffees[indexPath.item]
        
        let stepByStepVC = StepByStepViewController(currentRecipe: coffee)
        let navController = UINavigationController(rootViewController: stepByStepVC)
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 280)
    }
}


class CoffeeCell: UICollectionViewCell {
    
    static let identifier = "CoffeeCell"
    
    private let coffeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(coffeeImageView)
        contentView.addSubview(nameLabel)
        
        // Add constraints
        coffeeImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coffeeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coffeeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coffeeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coffeeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coffee: Sushi) {
        coffeeImageView.image = coffee.image
        nameLabel.text = coffee.name
    }
}

