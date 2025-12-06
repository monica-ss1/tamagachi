//
//  PetModel.swift
//  tamagachi
//
//  Created by Monica soliman on 11/25/25.
//
import Foundation
import Combine
import SwiftUI
import SpriteKit

class PetModel: ObservableObject {

    @Published var food = 100
    @Published var bath = 100
    @Published var affection = 100
    
    @Published var isDead = false

    private var timer: Timer?

    // pet sprite
    let pet = SKSpriteNode(imageNamed: "Character")
    
    // random movement
    func random(node: SKSpriteNode, within viewSize: CGSize) -> SKAction {
        let randomY = CGFloat.random(in: 0...viewSize.width)
        let NewPosition = CGPoint(x: 50, y: randomY)
        let Move = SKAction.move(to: NewPosition, duration: 2.0)
        return Move
    }
    
    init() {
        startDecay()
    }

    // Slow decrease over time
    func startDecay() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            self.decreaseStats()
        }
    }

    func stopDecay() {
        timer?.invalidate()
        timer = nil
    }

    func decreaseStats() {
        guard !isDead else { return }

        food = max(food - 5, 0)
        bath = max(bath - 4, 0)
        affection = max(affection - 6, 0)

        checkIfDead()
    }

    // Player actions
    func feed() {
        food = min(food + 20, 100)
    }

    func bathe() {
        bath = min(bath + 20, 100)
    }

    func love() {
        affection = min(affection + 20, 100)
    }

    func checkIfDead() {
        if food <= 0 || bath <= 0 || affection <= 0 {
            isDead = true
            stopDecay()
        }
    }

    func restart() {
        food = 100
        bath = 100
        affection = 100
        isDead = false
        startDecay()
    }
}
