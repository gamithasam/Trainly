//
//  TestCore.swift
//  Trainly
//
//  Created by Gamitha Samarasingha on 2024-12-24.
//

import SwiftUI
import CoreData

struct TestCore: View {
    @StateObject var vm = TrainlyViewModal()
    @State var textFieldText1: String = ""
    @State var textFieldText2: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                TextField("Add exercise here...", text: $textFieldText1)
                TextField("Add desc here...", text: $textFieldText2)
                
                Button(action: {
                    guard !textFieldText1.isEmpty || !textFieldText2.isEmpty else { return }
                    vm.addExercise(title: textFieldText1, desc: textFieldText2)
                    textFieldText1 = ""
                    textFieldText2 = ""
                }, label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(.pink))
                })
                
                List {
                    ForEach(vm.savedExercises) { entity in
                        Text(entity.name ?? "Hello")
                    }
                }
            }
            .navigationTitle("Exercises")
        }
    }
}

#Preview {
    TestCore()
}
