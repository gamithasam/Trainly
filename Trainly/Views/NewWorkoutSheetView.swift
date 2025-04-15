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
    @State var selectedWarmups: [ExerciseEntity] = []
    @State var selectedWorkouts: [ExerciseEntity] = []
    @State var selectedCooldowns: [ExerciseEntity] = []
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    @Binding var addWorkoutSheetPresented: Bool
    @StateObject var vm = TrainlyViewModal()
    @State private var editMode: EditMode = .active
    
    var body: some View {
        NavigationView {
            VStack {
//                if let unwrappedExercises = selectedWarmups {
//                    List {
//                        //                    ForEach(selectedExercises) { exercise in
//                        Text(unwrappedExercises.name ?? "No Name")
//                        //                    }
//                    }
//                }
                Group {
                    if let unwrappedImage = selectedImage {
                        Image(uiImage: unwrappedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 88)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.top)
                    } else {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 88)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                Image(systemName: "photo.badge.plus")
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                    Text(selectedImage == nil ? "Add Cover" : "Edit")
                        .foregroundColor(.accentColor)
                    
                }
                .onTapGesture {
                    isImagePickerPresented = true
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $selectedImage)
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
                            SelectExerciseView(type: "Warm-Up", selectedExercises: $selectedWarmups)
                        }
                        .foregroundColor(.accentColor)
                        ForEach(selectedWarmups, id: \.self) { warmup in
                            Text(warmup.name ?? "Unknown")
                        }
                        .onDelete { offsets in
                            delete(at: offsets, from: &selectedWarmups)
                        }
                        .onMove { source, destination in
                            move(from: source, to: destination, in: &selectedWarmups)
                        }
                        .moveDisabled(false)
                        
                    }
                    .environment(\.editMode, $editMode)
                    
                    Section {
                        NavigationLink("Workout") {
                            SelectExerciseView(type: "Workout", selectedExercises: $selectedWorkouts)
                        }
                        .foregroundColor(.accentColor)
                        ForEach(selectedWorkouts, id: \.self) { workout in
                            Text(workout.name ?? "Unknown")
                        }
                        .onDelete { offsets in
                            delete(at: offsets, from: &selectedWorkouts)
                        }
                        .onMove { source, destination in
                            move(from: source, to: destination, in: &selectedWorkouts)
                        }
                        .moveDisabled(false)
                    }
                    .environment(\.editMode, $editMode)
                    
                    Section {
                        NavigationLink("Cool-Down") {
                            SelectExerciseView(type: "Cool-Down", selectedExercises: $selectedCooldowns)
                        }
                        .foregroundColor(.accentColor)
                        ForEach(selectedCooldowns, id: \.self) { cooldown in
                            Text(cooldown.name ?? "Unknown")
                        }
                        .onDelete { offsets in
                            delete(at: offsets, from: &selectedCooldowns)
                        }
                        .onMove { source, destination in
                            move(from: source, to: destination, in: &selectedCooldowns)
                        }
                        .moveDisabled(false)
                    }
                    .environment(\.editMode, $editMode)
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
                        vm.addWorkout(title: title, desc: desc, cover: selectedImage)
                        title = ""
                        desc = ""
                        selectedImage = nil
                        addWorkoutSheetPresented = false
                    }
                    .fontWeight(.bold)
                    .disabled(title == "" || desc == "" || selectedImage == nil)
                }
            }
            .navigationTitle("New Workout")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func delete(at offsets: IndexSet, from list: inout [ExerciseEntity]) {
        list.remove(atOffsets: offsets)
    }

    private func move(from source: IndexSet, to destination: Int, in list: inout [ExerciseEntity]) {
        list.move(fromOffsets: source, toOffset: destination)
    }
}

//#Preview {
//    NewWorkoutSheetView(addWorkoutSheetPresented: .constant(true))
//}
