//
//  HomeView.swift
//  trial-1236
//
//  Created by ABHINAV ANAND  on 14/06/25.
//


import SwiftUI

// MARK: - VIEW
// The main dashboard screen of the app.
struct HomeView: View {
    
    // The view is driven by the state published by its ViewModel.
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    header
                    focusCard
                    quickActions
                    agendaSection
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .clipped() // Prevents shadow artifacts from scrolling
        }
    }
    
    // MARK: - Subviews
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.greeting)
                    .font(.custom("SFProDisplay-Medium", size: 18))
                    .foregroundColor(.appTextPrimary.opacity(0.6))
                // You can replace "Aura" with the user's name later.
                Text("Aura")
                    .font(.custom("SFProDisplay-Bold", size: 34))
                    .foregroundColor(.appTextPrimary)
            }
            Spacer()
            // Menu Button
            Button(action: viewModel.menuTapped) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2.weight(.bold))
                    .foregroundColor(.appTextPrimary)
                    .padding(12)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
            }
        }
    }
    
    private var focusCard: some View {
        ZStack(alignment: .topLeading) {
            // Card Background
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.appTextPrimary)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 15)
            
            // Decorative background symbol
            Image(systemName: "sparkle")
                .font(.system(size: 200))
                .foregroundColor(.white.opacity(0.1))
                .offset(x: 120, y: -20)
                .rotationEffect(.degrees(-25))
            
            // Card Content
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Focus of the Day")
                        .font(.custom("SFProDisplay-Medium", size: 17))
                    Image(systemName: "target")
                }
                .foregroundColor(.white.opacity(0.8))
                
                Text(viewModel.focusTitle)
                    .font(.custom("SFProDisplay-Bold", size: 28))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)

                Spacer()
                
                Text(viewModel.focusSubtitle)
                    .font(.custom("SFProDisplay-Semibold", size: 18))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.15))
                    .clipShape(Capsule())
            }
            .padding(24)
        }
        .frame(height: 200)
    }
    
    private var quickActions: some View {
        HStack(spacing: 20) {
            ForEach(viewModel.quickActions) { action in
                Button(action: { viewModel.quickActionTapped(action) }) {
                    VStack(spacing: 12) {
                        Image(systemName: action.symbol)
                            .font(.title)
                            .foregroundColor(.appAccent)
                            .frame(width: 64, height: 64)
                            .background(Color.appAccent.opacity(0.15))
                            .clipShape(Circle())
                        
                        Text(action.title)
                            .font(.custom("SFProDisplay-Medium", size: 14))
                            .foregroundColor(.appTextPrimary)
                    }
                }
                // Add a spacer to distribute them evenly
                if action.id != viewModel.quickActions.last?.id {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 10)
    }
    
    private var agendaSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Header
            HStack {
                Text("Today's Agenda")
                    .font(.custom("SFProDisplay-Bold", size: 22))
                    .foregroundColor(.appTextPrimary)
                Spacer()
                Button("View All", action: viewModel.viewAllTapped)
                     .font(.custom("SFProDisplay-Semibold", size: 16))
                     .foregroundColor(.appAccent)
            }
            
            // Agenda List
            VStack(spacing: 12) {
                ForEach(viewModel.agendaItems) { item in
                    agendaRow(item: item)
                }
            }
        }
    }
    
    private func agendaRow(item: AgendaItem) -> some View {
        HStack(spacing: 16) {
            Image(systemName: item.symbol)
                .font(.title2.weight(.semibold))
                .foregroundColor(item.color)
                .frame(width: 50, height: 50)
                .background(item.color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.custom("SFProDisplay-Semibold", size: 17))
                    .foregroundColor(.appTextPrimary)
                Text(item.subtitle)
                    .font(.custom("SFProDisplay-Regular", size: 15))
                    .foregroundColor(.appTextPrimary.opacity(0.6))
            }
            
            Spacer()
            
            Text(item.time)
                .font(.custom("SFProDisplay-Semibold", size: 16))
                .foregroundColor(.appTextPrimary.opacity(0.8))
        }
        .padding(12)
        .background(Color.gray.opacity(0.08))
        .cornerRadius(18)
        .onTapGesture {
            viewModel.agendaItemTapped(item)
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
