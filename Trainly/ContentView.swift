//
//  ContentView.swift
//  Trainly
//
//  Created by Gamitha Samarasingha on 2024-12-24.
//

import SwiftUI

struct ContentView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            SummaryView()
                .tabItem {
                    Label("Summary", systemImage: "figure.run.square.stack")
                }
            ActivityView()
                .tabItem {
                    Label("Activity", systemImage: "clock")
                }
            WorkoutsView()
                .tabItem {
                    Label("Workouts", systemImage: "dumbbell")
                }
        }
    }
}

#Preview {
    ContentView()
}
