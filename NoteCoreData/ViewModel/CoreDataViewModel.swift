//
//  CoreDataViewModel.swift
//  NoteCoreData
//
//  Created by Filip Hertzman on 2023-03-09.
//

import Foundation
import CoreData

class CoreDateViewModel: ObservableObject {
    
    // You can use NSPersistentContainer to perform common Core Data operations such as fetching, inserting, updating, and deleting managed objects. It also provides support for versioning and migration of Core Data models.
    let container: NSPersistentContainer
    @Published var savedTasks: [TaskEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "TaskContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error with core data. \(error)")
            } else {
                print("Sucesses with loading Core Data.")
            }
        }
        fetchTasks()
    }
    
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
           savedTasks = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    
    func deleteTask(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedTasks[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func addTask(text: String) {
        let newTask = TaskEntity(context: container.viewContext)
        newTask.task = text
        newTask.completed = false
        newTask.time = Date()
        saveData()
        
    }
    
    func saveData() {
        do {
           try container.viewContext.save()
            fetchTasks()
            
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    func toggleCompleted(entity: TaskEntity) {
        entity.completed.toggle()
        saveData()
    }
    
}
