//
//  StepByStepViewController.swift
//  SushiHub
//
//  Created by Babayev Kamran on 30.06.23.
//

import UIKit

class StepByStepViewController: UIViewController {
    
    private let coffeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let coffeeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 28)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    
    private var currentStepIndex = 0
    var currentRecipe: Sushi
    init(currentRecipe: Sushi) {
        self.currentRecipe = currentRecipe
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(coffeeImageView)
        view.addSubview(coffeeNameLabel)
        view.addSubview(instructionLabel)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        
        // Set up constraints
        
        // coffeeImageView constraints
        coffeeImageView.translatesAutoresizingMaskIntoConstraints = false
        coffeeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        coffeeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        coffeeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        coffeeImageView.heightAnchor.constraint(equalTo: coffeeImageView.widthAnchor, multiplier: 0.8).isActive = true
        
        // coffeeNameLabel constraints
        coffeeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        coffeeNameLabel.topAnchor.constraint(equalTo: coffeeImageView.bottomAnchor, constant: 20).isActive = true
        coffeeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        coffeeNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // instructionLabel constraints
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.topAnchor.constraint(equalTo: coffeeNameLabel.bottomAnchor, constant: 20).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // previousButton constraints
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        // nextButton constraints
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        coffeeImageView.layer.cornerRadius = 15
        
        loadRecipe(currentRecipe)
    }
    
    // MARK: - Button Actions
    
    @objc private func previousButtonTapped() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
            updateUI()
        }
    }
    
    @objc private func nextButtonTapped() {
        if currentStepIndex < currentRecipe.instructions.count ?? 0 - 1 {
            currentStepIndex += 1
            updateUI()
        }
    }
    
    // MARK: - Helper Methods
    
    private func loadRecipe(_ recipe: Sushi) {
        currentRecipe = recipe
        currentStepIndex = 0
        updateUI()
    }
    
    private func updateUI() {
        let recipe = currentRecipe
            
        
        
        coffeeImageView.image = recipe.image
        coffeeNameLabel.text = recipe.name
        
        let instructions = recipe.instructions
        
            if currentStepIndex >= 0 && currentStepIndex < instructions.count {
                instructionLabel.text = instructions[currentStepIndex]
            }
        
        
        previousButton.isEnabled = currentStepIndex > 0
        nextButton.isEnabled = currentStepIndex < (currentRecipe.instructions.count ?? 0) - 1
    }
}
