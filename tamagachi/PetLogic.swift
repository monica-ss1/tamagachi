//
//  PetLogic.swift
//  tamagachi
//
//  Created by Spencer Blunt on 11/18/25.
//


import SwiftUI
import SpriteKit

class PetBrain: SKScene {
    
    // set pet position
    override func didMove(to view: SKView) {
        SpawnPet(at:CGPoint(x: 200, y: 300))
    }
    func SpawnPet(at position: CGPoint) {
        // Set up sprite
        let NewPet = SKSpriteNode(imageNamed: "Character")
        NewPet.position = position
        NewPet.zPosition = 1
        addChild(NewPet)

        // Animation frames
        let frames = [
            SKTexture(imageNamed: "Character"),
            SKTexture(imageNamed: "pet walk 1"),
            SKTexture(imageNamed: "pet walk 2")
        ]

        let animation = SKAction.animate(with: frames, timePerFrame: 0.2)
        NewPet.run(SKAction.repeatForever(animation))
    }
    
    //
    
    
    // Death function
    func death(pet: SKSpriteNode) {
        let deathAction = SKAction.run {
            pet.texture = SKTexture(imageNamed: "death")
        }
        // kill
        pet.run(deathAction)
    }
}

