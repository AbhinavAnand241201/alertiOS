//
//  PermissionItem.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 13/06/25.
//


import Foundation
import SwiftUI

// MARK: - MODEL
// Represents a single permission item to be displayed on the permissions screen.
struct PermissionItem: Identifiable {
    let id = UUID()
    let symbol: String
    let title: String
    let description: String
    let symbolColor: Color
}
