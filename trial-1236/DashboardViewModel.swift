//
//  DashboardViewModel.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 14/06/25.
//


import Foundation
import SwiftUI

// MARK: - VIEWMODEL
// Manages all the data and logic for the main dashboard (HomeView).
@MainActor // Ensures UI updates are on the main thread.
class DashboardViewModel: ObservableObject {
    
    @Published var greeting: String = ""
    @Published var focusTitle: String = "Submit project proposal"
    @Published var focusSubtitle: String = "Due Today"
    @Published var agendaItems: [AgendaItem] = []
    @Published var quickActions: [QuickAction] = []
    
    init() {
        // This is where you would fetch real data from your services.
        // For now, we use sample data.
        setupGreeting()
        loadAgendaItems()
        loadQuickActions()
    }
    
    // --- PRIVATE SETUP FUNCTIONS ---
    
    private func setupGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            self.greeting = "Good morning"
        case 12..<18:
            self.greeting = "Good afternoon"
        default:
            self.greeting = "Good evening"
        }
    }
    
    private func loadAgendaItems() {
        // Sample data mimicking a user's schedule.
        self.agendaItems = [
            AgendaItem(symbol: "briefcase.fill", title: "Team Sync Meeting", subtitle: "Work", time: "10:00 AM", color: .blue),
            AgendaItem(symbol: "pills.fill", title: "Take Vitamin D", subtitle: "Health", time: "12:30 PM", color: .green),
            AgendaItem(symbol: "phone.fill", title: "Call Mom", subtitle: "Personal", time: "2:00 PM", color: .pink),
            AgendaItem(symbol: "dumbbell.fill", title: "Gym Session", subtitle: "Fitness", time: "6:00 PM", color: .orange)
        ]
    }
    
    private func loadQuickActions() {
        self.quickActions = [
            QuickAction(symbol: "plus.circle.fill", title: "New Task"),
            QuickAction(symbol: "bell.circle.fill", title: "Set Alarm"),
            QuickAction(symbol: "square.and.pencil.circle.fill", title: "New Note")
        ]
    }
    
    // --- INTENTS ---
    // Functions to handle user actions, to be called from the View.
    
    func quickActionTapped(_ action: QuickAction) {
        print("\(action.title) tapped.")
        // Navigation logic would go here.
    }
    
    func agendaItemTapped(_ item: AgendaItem) {
        print("\(item.title) tapped.")
        // Navigation logic would go here.
    }
    
    func viewAllTapped() {
        print("View All tapped.")
        // Navigation logic to a full agenda screen.
    }
    
    func menuTapped() {
        print("Menu tapped.")
        // Logic to show a settings sheet or side menu.
    }
}
