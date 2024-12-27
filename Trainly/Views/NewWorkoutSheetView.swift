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
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    @Binding var addWorkoutSheetPresented: Bool
    @StateObject var vm = TrainlyViewModal()
    
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
}

#Preview {
    NewWorkoutSheetView(addWorkoutSheetPresented: .constant(true))
}
