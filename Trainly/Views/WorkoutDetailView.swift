//
//  WorkoutView.swift
//  Trainly
//
//  Created by Gamitha Samarasingha on 2025-05-03.
//

import SwiftUI

struct WorkoutDetailView: View {
    var workout: WorkoutEntity

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background image
            if let data = workout.cover, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 222)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .overlay(Color.black.opacity(0.3))
                    .ignoresSafeArea(edges: .top)
            } else {
                Color.gray
                    .frame(height: 222)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(edges: .top)
            }

            // Content
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer().frame(height: 222)
                    Text(workout.name ?? "Unnamed Workout")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(workout.desc ?? "No description provided.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Spacer()
                }
            }
            .padding(.leading)
        }
        .ignoresSafeArea(edges: .all)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // TODO: Add action for more options
                }) {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

//#Preview {
//    NavigationStack {
//        WorkoutDetailView(workout: WorkoutEntity(name: "Sample Workout", desc: "A great session"))
//    }
//}
