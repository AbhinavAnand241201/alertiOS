//
//  contains.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 13/06/25.
//


import SwiftUI

// MARK: - VIEW
// This struct contains only the UI code for the onboarding flow.
// It's the "V" in MVVM.
struct OnboardingView: View {
    
    // @StateObject creates and owns the ViewModel instance.
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            if viewModel.showHomeView {
              AuthenticationView()
                    .transition(.opacity.animation(.easeInOut(duration: 0.5)))
            } else {
                mainOnboardingContent
                    .transition(.opacity)
            }
        }
    }
    
    private var mainOnboardingContent: some View {
        VStack {
            // TabView for swipeable pages
            TabView(selection: $viewModel.currentPage.animation()) {
                ForEach(viewModel.onboardingPages.indices, id: \.self) { index in
                    OnboardingCardView(info: viewModel.onboardingPages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer(minLength: 40)
            
            // Custom Page Indicator
            HStack(spacing: 8) {
                ForEach(0..<viewModel.onboardingPages.count, id: \.self) { index in
                    Capsule()
                        .fill(index == viewModel.currentPage ? Color.appAccent : Color.gray.opacity(0.5))
                        .frame(width: index == viewModel.currentPage ? 30 : 10, height: 10)
                }
            }
            .padding(.bottom, 30)

            // Action Button
            Button(action: {
                viewModel.advancePage()
            }) {
                Text(viewModel.buttonText)
                    .font(.custom("SFProDisplay-Bold", size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appAccent)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 50)
        }
    }
}

// Reusable card view (can be in its own file if it gets more complex)
struct OnboardingCardView: View {
    let info: OnboardingCardInfo

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: info.symbol)
                .font(.system(size: 100, weight: .bold))
                .foregroundColor(info.symbolColor)
                .shadow(color: info.symbolColor.opacity(0.3), radius: 20, x: 0, y: 10)
                .padding(.bottom, 50)

            Text(info.title)
                .font(.custom("SFProDisplay-Bold", size: 34))
                .foregroundColor(Color.appTextPrimary)
                .multilineTextAlignment(.center)

            Text(info.description)
                .font(.custom("SFProDisplay-Regular", size: 18))
                .foregroundColor(Color.appTextPrimary.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineSpacing(6)
        }
        .padding(.horizontal, 30)
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
