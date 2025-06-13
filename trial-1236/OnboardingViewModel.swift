import SwiftUI // <-- ADD THIS LINE

// MARK: - VIEWMODEL
// This class holds the data and business logic for the onboarding view.
// It's the "VM" in MVVM.
class OnboardingViewModel: ObservableObject {
    
    // @Published properties will notify the View of any changes.
    @Published var onboardingPages: [OnboardingCardInfo]
    @Published var currentPage: Int = 0
    @Published var showHomeView: Bool = false

    init() {
        // Initialize the onboarding pages data.
        self.onboardingPages = [
            OnboardingCardInfo(symbol: "sparkles", title: "Welcome to Aura", description: "Your new personal assistant for a calmer, more organized life.", symbolColor: Color.appAccent),
            OnboardingCardInfo(symbol: "checklist.checked", title: "Conquer Your Day", description: "Effortlessly manage tasks, set smart reminders, and achieve your goals.", symbolColor: .blue),
            OnboardingCardInfo(symbol: "heart.text.square.fill", title: "Prioritize Wellness", description: "Track your health, manage medications, and build better habits over time.", symbolColor: .green)
        ]
    }
    
    /// Advances to the next page or completes the onboarding process.
    func advancePage() {
        if currentPage < onboardingPages.count - 1 {
            currentPage += 1
        } else {
            completeOnboarding()
        }
    }
    
    /// The text to display on the main action button.
    var buttonText: String {
        return currentPage == onboardingPages.count - 1 ? "Get Started" : "Next"
    }
    
    /// Marks onboarding as complete and triggers the transition to the home screen.
    private func completeOnboarding() {
        showHomeView = true
        // Here you could also save a flag to UserDefaults
        // so the user doesn't see onboarding again.
        // UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}
