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
    
    var body: some View {
        NavigationView {
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
            .navigationTitle(type)
            .navigationBarTitleDisplayMode(.inline)
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
