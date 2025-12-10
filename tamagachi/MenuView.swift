import SwiftUI
import SwiftData

struct MenuView: View {
    @State private var navigationPath = NavigationPath()
    var body: some View {
        NavigationStack {
            ZStack {
                Image("MenuBack")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Image("menu title")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 6, height: 60)
                    .offset(y: -260)
                NavigationStack(path:$navigationPath){
                    VStack(spacing: -80){
                        NavigationLink(value: "game") {
                            Image("play button")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                        }
                        Button {
                            newTapped()
                            navigationPath.append("game")
                            
                        } label: {
                            Image("new game button")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                            
                        }
                        Button {
                            exitTapped()
                        } label: {
                            Image("exit button")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                        }
                        .navigationDestination(for: String.self) {
                            value in
                            if value == "game"{
                                GameView()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    func newTapped() {
        print("New Game tapped")
        let NewFunction = PetModel()
        NewFunction.restart()
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
