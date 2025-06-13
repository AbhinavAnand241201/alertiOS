//
//  PermissionsViewModel.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 13/06/25.
//


import Foundation
import UserNotifications // For Push Notifications
import EventKit // For Calendar Access
import CoreLocation // For Location Access

// MARK: - VIEWMODEL
// Manages the state and logic for requesting system permissions.
class PermissionsViewModel: ObservableObject {
    
    // Published properties to drive the UI
    @Published var permissionItems: [PermissionItem]
    @Published var allPermissionsGranted = false
    
    // Private manager for location services
    private let locationManager = CLLocationManager()
    
    init() {
        // Define the permissions your app needs.
        self.permissionItems = [
            PermissionItem(
                symbol: "bell.badge.fill",
                title: "Notifications",
                description: "To send you timely alerts for your tasks and medication reminders.",
                symbolColor: .appAccent
            ),
            PermissionItem(
                symbol: "calendar.badge.plus",
                title: "Calendar Access",
                description: "To sync your app's schedule with your device's calendar.",
                symbolColor: .blue
            ),
            PermissionItem(
                symbol: "location.fill.viewfinder",
                title: "Location Access",
                description: "For smart, location-based reminders, like 'pick up milk near the store'.",
                symbolColor: .green
            )
        ]
    }
    
    // --- INTENTS ---
    
    /// The main function to start the permission request sequence.
    func requestAllPermissions() {
        requestNotificationPermission {
            self.requestCalendarPermission {
                self.requestLocationPermission()
                
                // After all requests are made, move to the home screen.
                // The user can still deny them, but we won't block the app.
                DispatchQueue.main.async {
                    self.allPermissionsGranted = true
                }
            }
        }
    }
    
    /// Skips the permission granting process and proceeds to the home screen.
    func skipPermissions() {
        self.allPermissionsGranted = true
    }
    
    // --- PRIVATE HELPERS ---
    
    private func requestNotificationPermission(completion: @escaping () -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
            // Continue to the next permission request regardless of the result.
            completion()
        }
    }
    
    private func requestCalendarPermission(completion: @escaping () -> Void) {
        let eventStore = EKEventStore()
        eventStore.requestFullAccessToEvents { granted, error in
            if let error = error {
                 print("Error requesting calendar permission: \(error.localizedDescription)")
            }
             // Continue to the next permission request.
            completion()
        }
    }
    
    private func requestLocationPermission() {
        // We must have a description in Info.plist for this to work.
        // Key: "Privacy - When In Use Usage Description"
        locationManager.requestWhenInUseAuthorization()
    }
}
