//
//  NewWorkoutSheet.swift
//  Trainly
//
//  Created by Gamitha Samarasingha on 2024-12-24.
//

import SwiftUI

struct NewWorkoutSheetView: View {
    @State var title: String = ""
    @State var desc: String = ""
    @Binding var addWorkoutSheetPresented: Bool
    @StateObject var vm = TrainlyViewModal()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Row")
                    .padding()
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity)
                Button {
                    // Add cover
                } label: {
                    Text("Add Cover")
                }
                List {
                    Section {
                        HStack {
                            Text("Title")
                            TextField(text: $title) {
                                Text("enter title here")
                            }
                        }
                        HStack {
                            Text("Description")
                            TextField(text: $desc) {
                                Text("enter description here")
                            }
                        }
                    }
                    
                    Section {
                        NavigationLink("Warm-Up") {
                            SelectExerciseView(type: "Warm-Up")
                        }
                        .foregroundColor(.accentColor)
                    }
                    
                    Section {
                        NavigationLink("Workout") {
                            SelectExerciseView(type: "Workout")
                        }
                        .foregroundColor(.accentColor)
                    }
                    
                    Section {
                        NavigationLink("Cool-Down") {
                            SelectExerciseView(type: "Cool-Down")
                        }
                        .foregroundColor(.accentColor)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        addWorkoutSheetPresented = false
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        guard !title.isEmpty || !desc.isEmpty else { return }
                        vm.addWorkout(title: title, desc: desc)
                        title = ""
                        desc = ""
                        addWorkoutSheetPresented = false
                    }
                    .fontWeight(.bold)
                }
            }
            .navigationTitle("New Workout")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewWorkoutSheetView(addWorkoutSheetPresented: .constant(true))
}
