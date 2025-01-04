//
//  ContainerView.swift
//  SWE_Project
//
//  Created by Khalid R on 19/03/1446 AH.
//
import SwiftUI

struct ContainerView: View {
    @State private var selectedTab: TabViewModel = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(TabViewModel.home)
                    .ignoresSafeArea()
                

               JourneyView()
                    .tag(TabViewModel.saved)
                    .ignoresSafeArea()
                
                MapView()
                    .tag(TabViewModel.map)
                    .ignoresSafeArea()
            
                    ProfileView()
                    .tag(TabViewModel.settings)
                    .ignoresSafeArea()
            }
            .background(Color.white.ignoresSafeArea())
            
            customBarItem
                .background(Color.white)
                .frame(height: 85)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: -5)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden()
    }
}

struct NewTabItem: View  {
    var tab: TabViewModel = .home
    @Binding var activeTab: TabViewModel
    var body: some View {
        VStack(spacing: 5) {
            Image(activeTab == tab ? tab.tabedImages : tab.image)
                .resizable()
                .frame(width: (activeTab == tab) ? 30 : 30, height: (activeTab == tab) ? 30 : 30)
            
            Circle()
                .fill(activeTab == tab ? Color.greenApp : .clear)
                .frame(width: 10, height: 10)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(duration: 0.4)) {
                activeTab = tab
            }
            
        }
    }
}
#Preview(body: {
    ContainerView()

        .environmentObject(PlaceViewModel())

})

extension ContainerView  {
    private var customBarItem: some View {
        HStack(alignment: .bottom) {
            ForEach(TabViewModel.allCases, id: \.rawValue) {
                NewTabItem(tab: $0, activeTab: $selectedTab)
            }
        }
        .padding(.vertical, 10) 
    }
}

