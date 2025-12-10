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
    var pet: SKSpriteNode!
    
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
        self.pet = NewPet
        Movement(for: NewPet)
    }
    
    //random movement
    func Movement(for pet: SKSpriteNode) {
        let ranX = CGFloat.random(in: 50...(size.width - 50))
        let ranY = CGFloat.random(in: 50...(size.height - 50))
        let MovetoRan = CGPoint(x: ranX, y: ranY)
        
        // Animation frames
        let frames = [
            SKTexture(imageNamed: "Character"),
            SKTexture(imageNamed: "pet walk 1"),
            SKTexture(imageNamed: "pet walk 2")
        ]
        
        // create animation sequence
        let animation = SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: 0.2))
        
        pet.run(animation, withKey: "walk")
        
        // create movement back and forth sequence
        let move = SKAction.move(to: MovetoRan, duration: 3)
        
        let cycle = SKAction.sequence([move, SKAction.run { [weak self] in
                    guard let self = self else { return }
                    // stops animation
                    pet.removeAction(forKey: "walk")
                    pet.texture = SKTexture(imageNamed: "Character")
                    // resumes animation
                    self.Movement(for: pet)
            }
        ])
        pet.run(cycle)
    }
    
    
    // Death function
    func death() {
        pet.removeAllActions()
        pet.texture = SKTexture(imageNamed: "death")
    }
}

