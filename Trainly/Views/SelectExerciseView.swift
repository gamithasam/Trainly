//
//  SelectExerciseView.swift
//  Trainly
//
//  Created by Gamitha Samarasingha on 2024-12-24.
//

import SwiftUI

struct SelectExerciseView: View {
    let type: String
    @StateObject var vm = TrainlyViewModal()
    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 16)
    ]
    @State private var selectedIndex: ExerciseEntity?
    @State private var sets: Int = 1
    @State private var reps: Int = 1
    @State private var duration: Int = 1
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.savedExercises) { item in
                                ExerciseItem(
                                    geometry: geometry,
                                    isSelected: selectedIndex == item,
                                    item: item
                                )
                                .onTapGesture {
                                    if selectedIndex == item {
                                        selectedIndex = nil
                                    } else {
                                        selectedIndex = item
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                if selectedIndex != nil {
                    VStack {
                        Spacer()
                        
                        VStack {
                            List {
                                Section {
                                    HStack {
                                        Text("Sets:")
                                        Spacer()
                                        Stepper(value: $sets, in: 0...100) {
                                            Text("\(sets)")
                                        }
                                    }
                                }
                                
                                Section {
                                    HStack {
                                        Text("Duration:")
                                        Spacer()
                                        Stepper(value: $duration, in: 0...100) {
                                            Text("\(duration)")
                                        }
                                    }
                                    HStack {
                                        Text("Reps:")
                                        Spacer()
                                        Stepper(value: $reps, in: 0...100) {
                                            Text("\(reps)")
                                        }
                                    }
                                }
                            }
                            .frame(height: 200)
                            .padding(.bottom, 34)
                            .scrollDisabled(true)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            
                            Button(action: {
                                // TODO: add button action
                                reps = 1
                                sets = 1
                                duration = 1
                                selectedIndex = nil
                                showAlert = true
                            }) {
                                Text("Add")
                                    .foregroundColor(.white)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.accentColor)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                    }
                }
            }
            .navigationTitle(type)
            .navigationBarTitleDisplayMode(.inline)
            .alert("Done!", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Exercise added")
            }
        }
    }
}


struct ExerciseItem: View {
    let geometry: GeometryProxy
    let isSelected: Bool
    let item: ExerciseEntity
    
    var width:CGFloat {
        return (geometry.size.width - 48) / 3
    }
    var height:CGFloat {
        return 150/115*width
    }
    
    var body: some View {
        ZStack {
            if isSelected {
                RoundedRectangle(cornerRadius: 13.5)
                    .strokeBorder(Color.accentColor, lineWidth: 1.5)
                    .frame(width: width, height: height)
            }
            
            ZStack(alignment: .bottom) {
                // Add image here
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width-6, height: height-6)
                    
                ZStack {
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(width: width-6, height: 42/115*width)
                    
                    Text(item.name ?? "No Name")
                        .font(.caption)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(width: width, height: height)
        
    }
}

#Preview {
    SelectExerciseView(type: "Warm-Up")
}
