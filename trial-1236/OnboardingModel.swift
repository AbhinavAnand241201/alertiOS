//
//  represents.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 13/06/25.
//


import Foundation
import SwiftUI

// MARK: - MODEL
// This struct represents the data for a single onboarding screen.
// It's the "M" in MVVM.
struct OnboardingCardInfo: Identifiable {
    let id = UUID()
    let symbol: String
    let title: String
    let description: String
    let symbolColor: Color
}
