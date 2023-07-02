//
//  SushiCollectionViewController.swift
//  SushiHub
//
//  Created by Babayev Kamran on 30.06.23.
//

import UIKit

class SushiCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sushi Types"
        view.backgroundColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        // Set up recipe data
        recipes = createDummyRecipes() // Replace with actual recipe data
        
        // Set up collection view layout
        let itemSize = CGSize(width: 150, height: 200)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = itemSize
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }
        
        // Add constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.identifier, for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.item]
        cell.configure(with: recipe)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.item]
        
        // Show popup view with recipe details
        let popupView = RecipeDetailsPopupView(recipe: recipe)
        popupView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(popupView)
        
        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popupView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            popupView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75)
        ])
        
        view.layoutIfNeeded()
        popupView.transform = CGAffineTransform(translationX: 0, y: popupView.frame.height)
        
        UIView.animate(withDuration: 0.3) {
            popupView.transform = .identity
        }
        
        // Add pan gesture recognizer to dismiss the popup view
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        popupView.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Pan Gesture Recognizer
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .changed:
            let yTranslation = max(translation.y, 0)
            gesture.view?.transform = CGAffineTransform(translationX: 0, y: yTranslation)
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: view)
            if velocity.y >= 50 {
                dismissPopupView(gesture.view)
            } else {
                UIView.animate(withDuration: 0.3) {
                    gesture.view?.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    func dismissPopupView(_ view: UIView?) {
        UIView.animate(withDuration: 0.3, animations: {
            view?.transform = CGAffineTransform(translationX: 0, y: view?.frame.height ?? 0)
        }) { _ in
            view?.removeFromSuperview()
        }
    }
}

// MARK: - Dummy Recipe Data (Replace with your own recipe data)

func createDummyRecipes() -> [Recipe] {
    let recipe1 = Recipe(title: "Nigiri", image: UIImage(named: "Nigiri")!, description: "Nigiri sushi is a traditional Japanese dish made of hand-formed vinegared rice topped with fresh seafood or other ingredients. Its simple yet elegant presentation allows the natural flavors of the ingredients to shine.")

    let recipe2 = Recipe(title: "Maki", image: UIImage(named: "Maki")!, description: "Maki sushi, also known as sushi rolls, is a popular type of sushi where sushi rice, along with various fillings such as seafood, vegetables, and sauces, is wrapped in a sheet of seaweed (nori) and cut into bite-sized pieces. Maki rolls offer a diverse range of flavors, textures, and combinations, making them a versatile and enjoyable sushi option.")

    let recipe3 = Recipe(title: "Sashimi", image: UIImage(named: "Sashimi")!, description: "Sashimi is a Japanese delicacy consisting of thin slices of fresh, raw fish or seafood. Unlike sushi, sashimi does not include rice and is often enjoyed with soy sauce, wasabi, and pickled ginger to enhance its natural flavors.")

    let recipe4 = Recipe(title: "Temaki", image: UIImage(named: "Temaki")!, description: "Temaki sushi, also known as hand rolls, is a type of sushi where a cone-shaped seaweed (nori) wrap is filled with sushi rice, seafood, vegetables, and other ingredients. It is typically eaten with the hands and offers a fun and customizable dining experience, allowing each person to create their own unique combinations of flavors.")

    let recipe5 = Recipe(title: "Uramaki", image: UIImage(named: "Uramaki")!, description: "Uramaki sushi, also known as inside-out rolls, is a type of sushi where the rice is on the outside, and the seaweed (nori) is on the inside. It is often coated with sesame seeds or fish roe and can feature a variety of fillings such as seafood, vegetables, and sauces, offering a visually appealing and flavorful sushi option.")

    let recipe6 = Recipe(title: "Chirashi", image: UIImage(named: "Chirashi")!, description: "Chirashi sushi is a Japanese dish that consists of a bowl of sushi rice topped with an assortment of sashimi, vegetables, and other ingredients. The toppings are often arranged artistically and can vary depending on seasonal availability, making it a visually appealing and flavorful sushi variation.")

    let recipes = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6]
    
    return recipes

}

// MARK: - Recipe Details Popup View

class RecipeDetailsPopupView: UIView {
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 100
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    
    init(recipe: Recipe) {
        super.init(frame: .zero)
        
        backgroundColor = .black
        layer.cornerRadius = 10
        
        addSubview(recipeImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
//            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
//            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            recipeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: 250),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor, multiplier: 1),
            
            titleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
//            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        recipeImageView.image = recipe.image
        titleLabel.text = recipe.title
        descriptionLabel.text = recipe.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

