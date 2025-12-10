
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
import SpriteKit

struct GameView: View {
    @StateObject private var pet = PetModel()
    @Environment(\.dismiss) private var dismiss
    @State private var scene = PetBrain()
    @State private var SceneReady = false
    
    var body: some View {
            ZStack {
                // Background
                Image("GameView")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(edges: .all)
                    .clipped()
                
                // puts pet on top of background
                GeometryReader { geo in
                    SKViewContainer(scene: scene)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .onAppear {
                            if !SceneReady {
                                scene.size = geo.size
                                let center = CGPoint(x: geo.size.width/2, y: geo.size.height/2)
                                scene.SpawnPet(at: center)
                                scene.PetSpawned = true
                                scene.Movement(for: scene.pet)
                                SceneReady = true
                            }
                        }
                }

                
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
                    
                    
                    // Buttons at bottom
                    HStack {
                        Spacer()
                        
                        HStack(spacing: 50) {
                            // FOOD BUTTON (updated)
                            Button(action: pet.feed) {
                                Image("foodB")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80) //  image size
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                    .contentShape(Circle())
                            }
                            .buttonStyle(.plain)
                            .frame(width: 80, height: 80) // button keeps original space
                            
                            
                            // BATH BUTTON (updated)
                            Button(action: pet.bathe) {
                                Image("bathB")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                    .contentShape(Circle())
                            }
                            .buttonStyle(.plain)
                            .frame(width: 80, height: 80)
                            
                            
                            // AFFECTION BUTTON (updated)
                            Button(action: pet.love) {
                                Image("affectionB")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                    .contentShape(Circle())
                            }
                            .buttonStyle(.plain)
                            .frame(width: 80, height: 80)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 50)
                }
                
                // Main Menu Button top-right corner

                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                Image("main menu button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.trailing, 30)
                        
                        Spacer()
            }
        }
        .onAppear {
            // Spawn pet once when view appears
            if !scene.PetSpawned {
                let center = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY)
                    scene.SpawnPet(at: center)
                    scene.PetSpawned = true
                    scene.Movement(for: scene.pet)
                }
            }
        .overlay {
            if pet.isDead {
                VStack(spacing: 20) {
                    Text("💀 Your Pet Died 💀")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    
                    Button("Restart") {
                        pet.restart()
                        scene.pet.removeFromParent()
                        scene.PetSpawned = false
                        SceneReady = false
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
    }
    
    // Helper function for pet sprite spawning
    struct SKViewContainer: UIViewRepresentable {
        let scene: PetBrain

        func makeUIView(context: Context) -> SKView {
            let view = SKView()
            view.allowsTransparency = true  //for background image to show
            view.backgroundColor = .clear

            view.presentScene(scene)
            return view
        }

        func updateUIView(_ uiView: SKView, context: Context) {
            scene.size = uiView.bounds.size
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
