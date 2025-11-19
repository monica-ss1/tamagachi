//
//  PetLogic.swift
//  tamagachi
//
//  Created by Spencer Blunt on 11/18/25.
//

import SwiftUI
import SpriteKit

struct Pet {
    // pet sprite
    let pet = SKSpriteNode(imageNamed: "Character")
    
    //
    
    // random movement
    func random(node: SKSpriteNode, within viewSize: CGSize) -> SKAction {
        let randomY = CGFloat.random(in: 0...viewSize.width)
        let NewPosition = CGPoint(x: 50, y: randomY)
        let Move = SKAction.move(to: NewPosition, duration: 2.0)
        return Move
    }
    
    //
    
}
