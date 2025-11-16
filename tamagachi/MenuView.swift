//  MenuView.swift
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
import SwiftData

struct MenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Menu")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 25) {
                    NavigationLink(destination: GameView()) {
                        Text("Play")
                    }
                    .buttonStyle(MenuButtonStyle())

                    Button("Load") {
                        loadTapped()
                    }
                    .buttonStyle(MenuButtonStyle())

                    Button("Exit") {
                        exitTapped()
                    }
                    .buttonStyle(MenuButtonStyle())
                }
                Spacer()
                    .frame(height: 25)
                    .padding()
            }
        }
    }

    func loadTapped() {
        print("Load tapped")
    }

    func exitTapped() {
        print("Exit tapped")
        exit(0)
    }
}

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 350, height: 75)
            .background(Color.white)
            .foregroundColor(.black)
            .font(.system(size: 30, weight: .semibold))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    MenuView()
}
