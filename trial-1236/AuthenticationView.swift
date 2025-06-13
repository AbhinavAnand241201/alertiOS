import SwiftUI

// MARK: - VIEW
// The UI for the Sign Up / Login screen.
struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        // Full-screen view that handles navigation after authentication.
        // We use a NavigationStack to handle the transition smoothly.
        NavigationStack {
            ZStack {
                Color.appBackground.edgesIgnoringSafeArea(.all)
                
                VStack {
                    // We embed the content in a ScrollView to prevent overflow on smaller screens.
                    ScrollView {
                        content
                            .padding(.horizontal, 28) // Generous horizontal padding
                            .padding(.top, 60) // Generous top padding
                    }
                }
                .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                    PermissionsView() // Navigate to Permissions on success
                }
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            // --- Header Section ---
            // Notice the tight internal spacing and bold weight difference.
            Text("Welcome to Aura")
                .font(.custom("SFProDisplay-Bold", size: 36))
                .foregroundColor(.appTextPrimary)
            
            Text("Sign up or log in to begin your journey.")
                .font(.custom("SFProDisplay-Regular", size: 18))
                .foregroundColor(.appTextPrimary.opacity(0.6))
                .padding(.top, 8)
            
            // --- Form Section ---
            // Huge vertical space to separate sections.
            VStack(spacing: 18) {
                emailField
                passwordField
            }
            .padding(.top, 50)
            
            Spacer()
            
            // --- Action Buttons Section ---
            // A separate VStack at the bottom for actions.
            VStack(spacing: 16) {
                primaryButton(title: "Create Account", action: viewModel.signUp)
                secondaryButton(title: "Log In", action: viewModel.logIn)
                
                Text("OR")
                    .font(.custom("SFProDisplay-Semibold", size: 14))
                    .foregroundColor(.gray.opacity(0.8))
                    .padding(.vertical, 10)
                
                signInWithAppleButton()
            }
            .padding(.top, 120) // Give lots of space before buttons
        }
    }
    
    // MARK: - Subviews
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("Email Address", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .modifier(ModernTextFieldStyle()) // Apply custom style
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(viewModel.isEmailValid ? Color.clear : Color.red, lineWidth: 1.5)
                )
            
            if !viewModel.isEmailValid && !viewModel.email.isEmpty {
                Text("Please enter a valid email address.")
                    .font(.custom("SFProDisplay-Regular", size: 13))
                    .foregroundColor(.red)
                    .padding(.leading, 8)
            }
        }
    }
    
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 4) {
            SecureField("Password", text: $viewModel.password)
                .modifier(ModernTextFieldStyle()) // Apply custom style
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(viewModel.isPasswordValid ? Color.clear : Color.red, lineWidth: 1.5)
                )
            
             if !viewModel.isPasswordValid && !viewModel.password.isEmpty {
                Text("Password must be at least 6 characters.")
                    .font(.custom("SFProDisplay-Regular", size: 13))
                    .foregroundColor(.red)
                    .padding(.leading, 8)
            }
        }
    }
    
    private func primaryButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .modifier(PrimaryButtonStyle()) // Apply custom style
        }
    }
    
    private func secondaryButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .modifier(SecondaryButtonStyle()) // Apply custom style
        }
    }
    
    private func signInWithAppleButton() -> some View {
        Button(action: viewModel.signInWithApple) {
            HStack {
                Image(systemName: "apple.logo") // Correct SF Symbol name
                Text("Sign in with Apple")
            }
            .frame(maxWidth: .infinity)
            .modifier(SignInWithAppleStyle()) // Apply custom style
        }
    }
}

// MARK: - Custom View Modifiers for Styling
// This is the key to achieving the perfect, reusable design.

struct ModernTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProDisplay-Medium", size: 17))
            .padding(20)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
            .foregroundColor(.appTextPrimary)
    }
}

struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProDisplay-Bold", size: 18))
            .foregroundColor(.white)
            .padding()
            .background(Color.appAccent)
            .cornerRadius(16)
    }
}

struct SecondaryButtonStyle: ViewModifier {
     func body(content: Content) -> some View {
        content
            .font(.custom("SFProDisplay-Bold", size: 18))
            .foregroundColor(.appAccent)
            .padding()
            .background(Color.appAccent.opacity(0.15))
            .cornerRadius(16)
    }
}

struct SignInWithAppleStyle: ViewModifier {
     func body(content: Content) -> some View {
        content
            .font(.custom("SFProDisplay-Bold", size: 18))
            .foregroundColor(.white)
            .padding()
            .background(Color.black)
            .cornerRadius(16)
    }
}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
