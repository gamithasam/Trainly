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
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(vm.savedExercises) { item in
                    Text(item.name ?? "No Name")
                }
            }
            .navigationTitle(type)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SelectExerciseView(type: "Warm-Up")
}
