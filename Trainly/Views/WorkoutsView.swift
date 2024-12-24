//
//  WorkoutsView.swift
//  Trainly
//
//  Created by Gamitha Samarasingha on 2024-12-24.
//

import SwiftUI

struct WorkoutsView: View {
    @StateObject var vm = TrainlyViewModal()
    @State private var addWorkoutSheetPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.savedWorkouts) { item in
                    Text(item.name ?? "No Name")
                }
            }
                .navigationTitle("Workouts")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: Button(action: {
                    addWorkoutSheetPresented.toggle()
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $addWorkoutSheetPresented) {
                    NewWorkoutSheetView(addWorkoutSheetPresented: $addWorkoutSheetPresented)
                }
        }
    }
}

#Preview {
    WorkoutsView()
}
