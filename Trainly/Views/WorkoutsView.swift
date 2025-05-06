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
    
    init(vm: TrainlyViewModal = TrainlyViewModal()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.savedWorkouts) { item in
                    NavigationLink(destination: WorkoutDetailView(workout: item)) {
                        ZStack {
                            if let data = item.cover, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 88)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                                    .cornerRadius(10)
                            } else {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 88)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(10)
                            }
                            
                            Color.black
                                .opacity(0.3)
                            
                            VStack {
                                Text(item.name ?? "No Name")
                                    .font(.largeTitle)
                                Text(item.desc ?? "No Description")
                                    .font(.title2)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 20)
                }
                .onDelete(perform: vm.deleteWorkout)
            }
            .padding(.horizontal)
            .listStyle(PlainListStyle())
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
    WorkoutsView(vm: TrainlyViewModal.preview())
}
