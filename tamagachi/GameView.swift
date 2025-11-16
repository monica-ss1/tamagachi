import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    
    // Scores
    @State private var foodScore = 100
    @State private var bathScore = 100
    @State private var affectionScore = 100

    var body: some View {
        ZStack {
            // Background
            Image("GameView")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            VStack {
                // Scoreboard at the top
                HStack(spacing: 40) { // spacing between icons
                    VStack {
                        Image("Food")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        Text("\(foodScore)")
                            .foregroundColor(.white)
                            .bold()
                    }

                    VStack {
                        Image("Bath")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        Text("\(bathScore)")
                            .foregroundColor(.white)
                            .bold()
                    }

                    VStack {
                        Image("Affection")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        Text("\(affectionScore)")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 20)
                
                Spacer() // pushes character toward the bottom
                
                // Character
                Image("Character")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    GameView()
}


