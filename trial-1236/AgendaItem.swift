//
//  AgendaItem.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 14/06/25.
//


import Foundation
import SwiftUI

// MARK: - MODEL

// Represents a single item in the "Today's Agenda" list.
struct AgendaItem: Identifiable {
    let id = UUID()
    let symbol: String
    let title: String
    let subtitle: String
    let time: String
    let color: Color
}

// Represents a single quick action button.
struct QuickAction: Identifiable {
    let id = UUID()
    let symbol: String
    let title: String
}
