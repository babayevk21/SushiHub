//
//  Sushi.swift
//  SushiHub
//
//  Created by Babayev Kamran on 30.06.23.
//

import Foundation
import UIKit

class Sushi {
    let name: String
    let image: UIImage
    let instructions: [String]
    
    init(name: String, image: UIImage, instructions: [String]) {
        self.name = name
        self.image = image
        self.instructions = instructions
    }
}
