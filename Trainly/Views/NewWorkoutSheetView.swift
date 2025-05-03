//
//  NewWorkoutSheet.swift
//  Trainly
//
//  Created by Gamitha Samarasingha on 2024-12-24.
//

import SwiftUI

// Add this struct at the top level (outside the View struct)
struct ExerciseWrapper: Identifiable, Equatable {
    let id = UUID()
    let entity: ExerciseEntity
    let name: String
    
    init(entity: ExerciseEntity) {
        self.entity = entity
        self.name = entity.name ?? "Unknown"
    }
    
    static func == (lhs: ExerciseWrapper, rhs: ExerciseWrapper) -> Bool {
        return lhs.id == rhs.id
    }
}

struct NewWorkoutSheetView: View {
    @State var title: String = ""
    @State var desc: String = ""
    @State var selectedWarmups: [ExerciseWrapper] = []
    @State var selectedWorkouts: [ExerciseWrapper] = []
    @State var selectedCooldowns: [ExerciseWrapper] = []
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    @Binding var addWorkoutSheetPresented: Bool
    @StateObject var vm = TrainlyViewModal()
    @State private var editMode: EditMode = .active
    
    var body: some View {
        NavigationView {
            VStack {
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
                            SelectExerciseView(type: "Warm-Up", selectedExercises: Binding(
                                get: { selectedWarmups.map { $0.entity } },
                                set: { newValue in
                                    selectedWarmups = newValue.map { ExerciseWrapper(entity: $0) }
                                }
                            ))
                        }
                        .foregroundColor(.accentColor)
                        ForEach(selectedWarmups) { wrapper in
                            Text(wrapper.name)
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
                            SelectExerciseView(type: "Workout", selectedExercises: Binding(
                                get: { selectedWorkouts.map { $0.entity } },
                                set: { newValue in
                                    selectedWorkouts = newValue.map { ExerciseWrapper(entity: $0) }
                                }
                            ))
                        }
                        .foregroundColor(.accentColor)
                        ForEach(selectedWorkouts) { wrapper in
                            Text(wrapper.name)
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
                            SelectExerciseView(type: "Cool-Down", selectedExercises: Binding(
                                get: { selectedCooldowns.map { $0.entity } },
                                set: { newValue in
                                    selectedCooldowns = newValue.map { ExerciseWrapper(entity: $0) }
                                }
                            ))
                        }
                        .foregroundColor(.accentColor)
                        ForEach(selectedCooldowns) { wrapper in
                            Text(wrapper.name)
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
                        // Convert wrappers back to entities before saving
                        let warmupEntities = selectedWarmups.map { $0.entity }
                        let workoutEntities = selectedWorkouts.map { $0.entity }
                        let cooldownEntities = selectedCooldowns.map { $0.entity }
                        
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
    
    private func delete(at offsets: IndexSet, from list: inout [ExerciseWrapper]) {
        list.remove(atOffsets: offsets)
    }

    private func move(from source: IndexSet, to destination: Int, in list: inout [ExerciseWrapper]) {
        list.move(fromOffsets: source, toOffset: destination)
    }
}

//#Preview {
//    NewWorkoutSheetView(addWorkoutSheetPresented: .constant(true))
//}
