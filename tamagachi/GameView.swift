import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var pet = PetModel()

    var body: some View {
        ZStack {
            // Background
            Image("GameView")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                // Top-left vertical scoreboard
                VStack(alignment: .leading, spacing: -10) {
                    
                    // FOOD
                    HStack(spacing: 3) {
                        Image("Food")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 70)
                        Text("\(pet.food)")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title2)
                    }
                    
                    // BATH
                    HStack(spacing: 3) {
                        Image("Bath")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 70)
                        Text("\(pet.bath)")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title2)
                    }
                    
                    // AFFECTION
                    HStack(spacing: 3) {
                        Image("Affection")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 70)
                        Text("\(pet.affection)")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title2)
                    }
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
                    
                    Spacer()   // pushes buttons inward
                }
                .padding(.bottom, 50) }
        }
        .overlay {
            if pet.isDead {
                deathOverlay
            }
        }
    }

    // Death
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

#Preview {
    GameView()
}
