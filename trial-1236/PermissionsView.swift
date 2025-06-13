//
//  PermissionsView.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 13/06/25.
//


import SwiftUI

// MARK: - VIEW
// The UI for the Permissions screen.
struct PermissionsView: View {
    
    @StateObject private var viewModel = PermissionsViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.allPermissionsGranted {
                HomeView()
                    .transition(.opacity.animation(.easeInOut))
            } else {
                content
            }
        }
    }
    
    var content: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                // Header
                Text("Enable Awesome Features")
                    .font(.custom("SFProDisplay-Bold", size: 34))
                    .foregroundColor(.appTextPrimary)
                    .padding(.bottom, 10)
                
                Text("Aura works best with the following permissions. You can change these later in settings.")
                    .font(.custom("SFProDisplay-Regular", size: 17))
                    .foregroundColor(.appTextPrimary.opacity(0.7))
                    .lineSpacing(5)
                
                // List of Permissions
                List {
                    ForEach(viewModel.permissionItems) { item in
                        PermissionRowView(item: item)
                    }
                    .listRowBackground(Color.appBackground)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button(action: viewModel.requestAllPermissions) {
                        Text("Continue")
                            .font(.custom("SFProDisplay-Bold", size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.appAccent)
                            .cornerRadius(14)
                    }
                    
                    Button(action: viewModel.skipPermissions) {
                        Text("Maybe Later")
                            .font(.custom("SFProDisplay-Bold", size: 18))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 40)
        }
    }
}

// A reusable view for a single row in the permissions list.
struct PermissionRowView: View {
    let item: PermissionItem
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: item.symbol)
                .font(.title)
                .foregroundColor(item.symbolColor)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.custom("SFProDisplay-Bold", size: 18))
                    .foregroundColor(.appTextPrimary)
                
                Text(item.description)
                    .font(.custom("SFProDisplay-Regular", size: 15))
                    .foregroundColor(.appTextPrimary.opacity(0.7))
                    .lineSpacing(4)
            }
        }
        .padding(.vertical, 10)
    }
}

struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView()
    }
}