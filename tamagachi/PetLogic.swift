// PetLogic.swift
//  tamagachi
//
//  Created by Spencer Blunt on 11/18/25.
//


import SwiftUI
import SpriteKit

class PetBrain: SKScene {
    
    // pet object
    var pet: SKSpriteNode!
    var PetSpawned = false
    
    // set pet position
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        super.didMove(to: view)
        self.size = view.bounds.size
    }
    
    func SpawnPet(at position: CGPoint) {
        // FIX: allow respawn by removing old pet if it exists
        if pet != nil {
            pet.removeFromParent()
            pet = nil
        }
        
        // Set up sprite
        pet = SKSpriteNode(imageNamed: "Character")
        pet.position = position
        pet.zPosition = 1
        addChild(pet)
    }
    
    // Random movement
    func Movement(for pet: SKSpriteNode) {
        guard size.width > 0 && size.height > 0 else {
            // Retry after short delay if size not ready
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else { return }
                self.Movement(for: pet)
            }
            return
        }
        
        let margin: CGFloat = 50
        let ranX = CGFloat.random(in: margin...(size.width - margin))
        let ranY = CGFloat.random(in: margin...(size.height - margin))
        let MovetoRan = CGPoint(x: ranX, y: ranY)
        
        pet.xScale = (MovetoRan.x < pet.position.x) ? -1 : 1
        
        // Animation frames
        let frames = [
            SKTexture(imageNamed: "Character"),
            SKTexture(imageNamed: "pet walk 1"),
            SKTexture(imageNamed: "pet walk 2")
        ]
        
        // Create animation sequence
        let animation = SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: 0.2))
        pet.run(animation, withKey: "walk")
        
        // Create movement back and forth sequence
        let move = SKAction.move(to: MovetoRan, duration: 3)
        
        let cycle = SKAction.sequence([
            move,
            SKAction.run { [weak self] in
                guard let self = self else { return }
                // Stops animation
                pet.removeAction(forKey: "walk")
                pet.texture = SKTexture(imageNamed: "Character")
                // Resume movement
                self.Movement(for: pet)
            }
        ])
        pet.run(cycle, withKey: "move")
    }
    
    // Restart function
    func ResetPet() {
        self.removeAllActions()
        self.removeAllChildren()
        self.pet = nil     // FIX: allow respawn
        self.PetSpawned = false
    }
    
    // Death function
    func death() {
        pet.removeAllActions()
        pet.texture = SKTexture(imageNamed: "death")
    }
}
