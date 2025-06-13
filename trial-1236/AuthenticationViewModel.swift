//
//  AuthenticationViewModel.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 13/06/25.
//


import Foundation
import Combine // Import Combine for debouncing

// MARK: - VIEWMODEL
// Manages the state and logic for the authentication screen.
class AuthenticationViewModel: ObservableObject {
    
    // @Published properties for the input fields.
    @Published var email = ""
    @Published var password = ""
    
    // @Published properties to provide validation feedback to the View.
    @Published var isEmailValid = true
    @Published var isPasswordValid = true
    
    // Property to control navigation after successful login.
    @Published var isAuthenticated = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Debounce email validation to avoid validating on every keystroke.
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { email in
                // Simple regex for email validation.
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                return emailPredicate.evaluate(with: email) || email.isEmpty
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
        
        // Simple password validation (e.g., must be at least 6 characters).
        $password
            .map { password in
                return password.count >= 6 || password.isEmpty
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellables)
    }
    
    // --- INTENTS ---
    // These functions represent user actions.
    
    func signUp() {
        // Placeholder for your sign-up logic (e.g., Firebase, your own backend).
        print("Attempting to sign up with Email: \(email), Password: \(password)")
        
        // On successful signup:
        // self.isAuthenticated = true
    }
    
    func logIn() {
        // Placeholder for your login logic.
        print("Attempting to log in with Email: \(email), Password: \(password)")
        
        // On successful login:
        // self.isAuthenticated = true
    }
    
    func signInWithApple() {
        // Placeholder for "Sign in with Apple" logic.
        print("Attempting to sign in with Apple...")
        
        // On successful login:
        // self.isAuthenticated = true
    }
}
