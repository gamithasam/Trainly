//
//  TrainlyViewModal.swift
//  Trainly
//
//  Created by Gamitha Samarasingha on 2024-12-24.
//

import CoreData
import UIKit

class TrainlyViewModal: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedExercises: [ExerciseEntity] = []
    @Published var savedWorkouts: [WorkoutEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "Trainly")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading core data: \(error)")
            }
        }
        fetchExercises()
        fetchWorkouts()
    }
    
    func fetchExercises() {
        let request = NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
        
        do {
            savedExercises = try container.viewContext.fetch(request)
        } catch let error {
            fatalError("Error fetching: \(error)")
        }
    }
    
    func fetchWorkouts() {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        
        do {
            savedWorkouts = try container.viewContext.fetch(request)
        } catch let error {
            fatalError("Error fetching: \(error)")
        }
    }
    
    func addExercise(title: String, desc: String) {
        let newExercise = ExerciseEntity(context: container.viewContext)
        newExercise.name = title
        newExercise.desc = desc

        saveExercise()
    }
    
    func addWorkout(title: String, desc: String, cover: UIImage?) {
        let newWorkout = WorkoutEntity(context: container.viewContext)
        newWorkout.name = title
        newWorkout.desc = desc
        
        // Convert UIImage to Data
        if let uiImage = cover {
            newWorkout.cover = uiImage.pngData()
        }

        saveWorkout()
    }
    
    func saveExercise() {
        saveContainer()
        fetchExercises()
    }
    
    func saveWorkout() {
        saveContainer()
        fetchWorkouts()
    }
    
    func saveContainer() {
        do {
            try container.viewContext.save()
        } catch let error {
            fatalError("Error saving: \(error)")
        }
    }
    
    func deleteExercise(indexSet: IndexSet) {
        indexSet.map { savedExercises[$0] }.forEach { item in
            container.viewContext.delete(item)
        }
        saveExercise()
    }
    
    func deleteWorkout(indexSet: IndexSet) {
        indexSet.map { savedWorkouts[$0] }.forEach { item in
            container.viewContext.delete(item)
        }
        saveWorkout()
    }
    
    func updateExercise(entity: ExerciseEntity) {
        let currentName = entity.name ?? "No name"
        let currentDesc = entity.desc ?? "No desc"
        let newName = currentName + "!"
        let newDesc = currentDesc + "!"
        entity.name = newName
        entity.desc = newDesc
        saveExercise()
    }
    
    func updateWorkout(entity: WorkoutEntity) {
        let currentName = entity.name ?? "No name"
        let currentDesc = entity.desc ?? "No desc"
        let newName = currentName + "!"
        let newDesc = currentDesc + "!"
        entity.name = newName
        entity.desc = newDesc
        saveWorkout()
    }
}


extension TrainlyViewModal {
    static func preview() -> TrainlyViewModal {
        let vm = TrainlyViewModal()
        
        // Add sample workouts
        let sampleWorkouts = [
            ("Morning Workout", "A refreshing start to your day"),
            ("Strength Training", "Build muscle and strength"),
            ("Cardio Blast", "High-intensity cardio workout")
        ]
        
        let sampleImage = UIImage(named: "Row")
        for (title, desc) in sampleWorkouts {
            vm.addWorkout(title: title, desc: desc, cover: sampleImage)
        }
        
        return vm
    }
}
