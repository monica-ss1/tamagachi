//
//  PetLogic.swift
//  tamagachi
//
//  Created by Spencer Blunt on 11/18/25.
//


import SwiftUI
import SpriteKit

class GameScene: SKScene {
    
    // pet sprite stored as a property
    let pet = SKSpriteNode(imageNamed: "Character")
    
    override func didMove(to view: SKView) {
        // Set up sprite
        pet.position = CGPoint(x: 200, y: 200)
        addChild(pet)

        // Animation frames
        let frames = [
            SKTexture(imageNamed: "Character"),
            SKTexture(imageNamed: "pet walk 1"),
            SKTexture(imageNamed: "pet walk 2")
        ]

        let animation = SKAction.animate(with: frames, timePerFrame: 0.2)
        pet.run(SKAction.repeatForever(animation))
    }
    
    func death() {
        let deathAction = SKAction.run {
            self.pet.texture = SKTexture(imageNamed: "death")
        }
        
        pet.run(deathAction)
    }
}

