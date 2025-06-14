import SwiftUI

// Main entry point of the application.
@main
struct PersonalAssistantApp: App {
    var body: some Scene {
        WindowGroup {
            // ContentView is the root view, managing the initial launch flow.
            ContentView()
        }
    }
}

// ContentView only handles the initial Splash -> Onboarding transition.
struct ContentView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        // Wait for 2.5 seconds, then hide the splash screen.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                self.showSplash = false
                            }
                        }
                    }
            } else {
                // After the splash screen, the OnboardingView takes over.
                // It will manage its own state and transition to HomeView.
                OnboardingView()
            }
        }
    }
}

// MARK: - Splash Screen View and HomeView Placeholder
// Note: You can move these structs to their own separate files for better organization.

struct SplashScreenView: View {
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "sparkle")
                    .font(.system(size: 120))
                    .foregroundColor(Color.appAccent)
                    .shadow(color: Color.appAccent.opacity(0.3), radius: 20, x: 0, y: 10)
                Text("Aura")
                    .font(.custom("SFProDisplay-Bold", size: 44))
                    .foregroundColor(Color.appTextPrimary.opacity(0.8))
                    .padding(.top, 20)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 1.0)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
            }
        }
    }
}

// This is the final destination after onboarding is complete.
//struct HomeView: View {
//    var body: some View {
//        ZStack {
//            Color.appBackground.edgesIgnoringSafeArea(.all)
//            VStack {
//                 Text("Home Screen")
//                    .font(.custom("SFProDisplay-Bold", size: 34))
//                    .foregroundColor(Color.appTextPrimary)
//            }
//        }
//    }
//}


// MARK: - Reusable Color Extensions
// Note: It's best practice to move these extensions to their own file, e.g., "Extensions.swift".

extension Color {
    static let appBackground = Color(hex: "#FFFFFF")
    static let appTextPrimary = Color(hex: "#292725")
    static let appAccent = Color(hex: "#FF603D")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
