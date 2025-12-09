
//  tamagachi
//
//  Created by Monica soliman on 11/12/25.
//


//
//  ContentView.swift
//  Tomagatchi But Better
//
//  Created by csuftitan on 10/22/25.
//

import SwiftUI

struct GameView: View {
    @StateObject private var pet = PetModel()
    
    var body: some View {
        ZStack {
            // Background
            Image("GameView")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                // Top-left vertical scoreboard with progress bars
                VStack(alignment: .leading, spacing: -10) {
                    StatBar(imageName: "Food", value: pet.food, color: getColor(for: pet.food))
                    StatBar(imageName: "Bath", value: pet.bath, color: getColor(for: pet.bath))
                    StatBar(imageName: "Affection", value: pet.affection, color: getColor(for: pet.affection))
                }
                .padding(.top, 30)
                .padding(.leading, 9)
                
                Spacer()
                
                // Character at bottom
                Image("Character")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                
                // Buttons at bottom
                HStack {
                    Spacer()
                    
                    HStack(spacing: 50) {
                        
                        // FEED BUTTON
                        Button(action: pet.feed) {
                            Text("🍖")
                                .font(.system(size: 40))
                                .frame(width: 80, height: 80)
                                .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        
                        // BATH BUTTON
                        Button(action: pet.bathe) {
                            Text("🧼")
                                .font(.system(size: 40))
                                .frame(width: 80, height: 80)
                                .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                                .clipShape(Circle())
                                .shadow(radius: 6)
                        }
                        
                        // LOVE BUTTON
                        Button(action: pet.love) {
                            Text("💗")
                                .font(.system(size: 40))
                                .frame(width: 80, height: 80)
                                .background(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
                                .clipShape(Circle())
                                .shadow(radius: 6)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 50)
            }
        }
        .overlay {
            if pet.isDead {
                deathOverlay
            }
        }
    }
    
    // Helper function for color based on value
    func getColor(for value: Int) -> Color {
        if value > 60 {
            return .green
        } else if value > 30 {
            return .red
        } else {
            return .yellow
        }
    }

    // Death overlay
    private var deathOverlay: some View {
        VStack(spacing: 20) {
            Text("💀 Your Pet Died 💀")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()

            Button("Restart") {
                pet.restart()
            }
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .bold()
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.7))
        .ignoresSafeArea()
    }
}

// StatBar component with image overlaying progress bar
struct StatBar: View {
    let imageName: String
    let value: Int
    let color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Progress bar and text (background layer)
            HStack(spacing: 3) {
                // Empty space for the image to overlap
                Spacer()
                    .frame(width: 22)
                
                VStack(alignment: .leading, spacing: 2) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 12)
                        
                        RoundedRectangle(cornerRadius: 0)
                            .fill(color)
                            .frame(width: CGFloat(value), height: 30)
                            .animation(.easeInOut(duration: 0.3), value: value)
                    }
                }
            }
            
            // Image overlaying on top (foreground layer)
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 70)
                
                Spacer()
            }
        }
        .frame(height: 70)
    }
}

#Preview {
    GameView()
}
