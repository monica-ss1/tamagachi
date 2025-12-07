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
    
    // decay rate per 20 minutes offline/online
        private let foodDecay = 2
        private let bathDecay = 2
        private let affectionDecay = 3

        // decay interval (20 minutes)
        private let decayInterval: TimeInterval = 60 * 5

        init() {
            loadStats()
            applyOfflineDecay()
            startDecay()
        }
    // SAVE + LOAD

        func saveStats() {
            UserDefaults.standard.set(food, forKey: "food")
            UserDefaults.standard.set(bath, forKey: "bath")
            UserDefaults.standard.set(affection, forKey: "affection")
            UserDefaults.standard.set(isDead, forKey: "isDead")
            UserDefaults.standard.set(Date(), forKey: "lastOpened") // save timestamp
        }

        func loadStats() {
            let savedFood = UserDefaults.standard.integer(forKey: "food")
            let savedBath = UserDefaults.standard.integer(forKey: "bath")
            let savedAffection = UserDefaults.standard.integer(forKey: "affection")

            // If no data saved yet → default to 100
            if savedFood == 0 && savedBath == 0 && savedAffection == 0 {
                food = 100
                bath = 100
                affection = 100
                isDead = false
            } else {
                food = savedFood
                bath = savedBath
                affection = savedAffection
                isDead = UserDefaults.standard.bool(forKey: "isDead")
            }
        }
    // offline decay

        func applyOfflineDecay() {
            guard !isDead else { return }

            let lastOpened = UserDefaults.standard.object(forKey: "lastOpened") as? Date ?? Date()
            let secondsAway = Date().timeIntervalSince(lastOpened)

            if secondsAway <= 0 { return }

            let intervalsPassed = Int(secondsAway / decayInterval)

            if intervalsPassed > 0 {
                food = max(food - (foodDecay * intervalsPassed), 0)
                bath = max(bath - (bathDecay * intervalsPassed), 0)
                affection = max(affection - (affectionDecay * intervalsPassed), 0)

                checkIfDead()
                saveStats()
            }
        }


    // Slow decrease over time
    func startDecay() {
            timer = Timer.scheduledTimer(withTimeInterval: decayInterval, repeats: true) { _ in
                self.decreaseStats()
        }
    }

    func stopDecay() {
        timer?.invalidate()
        timer = nil
    }

    func decreaseStats() {
        guard !isDead else { return }

        food = max(food - foodDecay, 0)
                bath = max(bath - bathDecay, 0)
                affection = max(affection - affectionDecay, 0)

                checkIfDead()
                saveStats()
            }

    // Player actions
    func feed() {
        food = min(food + 2, 100)
        saveStats()
    }

    func bathe() {
        bath = min(bath + 2, 100)
        saveStats()
    }

    func love() {
        affection = min(affection + 2, 100)
        saveStats()
    }

    func checkIfDead() {
        if food <= 0 || bath <= 0 || affection <= 0 {
            isDead = true
            saveStats()
            stopDecay()
        }
    }

    func restart() {
        food = 100
        bath = 100
        affection = 100
        isDead = false
        saveStats()
        startDecay()
    }
}

