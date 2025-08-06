import SwiftUI

@main
struct diceHackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional for cleaner window
    }
}

struct ContentView: View {
    @State private var currentScreen: Screen = .start
    @State private var diceSides: [DiceSide] = [
        DiceSide(image: Image("1"), text: ""),
        DiceSide(image: Image("2"), text: ""),
        DiceSide(image: Image("3"), text: "Free choice"),
        DiceSide(image: Image("4"), text: ""),
        DiceSide(image: Image("5"), text: ""),
        DiceSide(image: Image("6"), text: "")
    ]
    
    var body: some View {
        Group {
            switch currentScreen {
            case .start:
                StartScreen(onStart: {
                    currentScreen = .setupDice
                })
            case .setupDice:
                SetupDiceScreen(onNext: { _ in
                    currentScreen = .roll
                }, diceSides: $diceSides)
            case .roll:
                RollScreen(diceSides: diceSides, onRollAgain: {
                    currentScreen = .setupDice
                })
            }
        }
    }
}
