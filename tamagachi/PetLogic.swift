//
//  PetLogic.swift
//  tamagachi
//
//  Created by Spencer Blunt on 11/18/25.
//


import SwiftUI
import SpriteKit

class PetBrain: SKScene {
    // pet object
    let pet = SKSpriteNode(imageNamed: "Character")
    
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
        Movement()
    }
    
    //random movement
    func Movement() {
        let ranX = CGFloat.random(in: 50...(size.width - 50))
        let ranY = CGFloat.random(in: 50...(size.height - 50))
        let MovetoRan = SKAction.move(to: CGPoint(x: ranX, y: ranY), duration: 3)
        let RepeatMove = SKAction.sequence([MovetoRan, SKAction.run(Movement)])
        pet.run(RepeatMove)
    }
    
    // Death function
    func death(pet: SKSpriteNode) {
        let deathAction = SKAction.run {
            pet.texture = SKTexture(imageNamed: "death")
        }
        // kill
        pet.run(deathAction)
    }
}

