//
//  StorageContainer.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 12/06/23.
//

import Foundation
import CoreData

class StorageContainer: ObservableObject {
    let container = NSPersistentContainer(name: "ToDo")
    
    static let shared = StorageContainer()
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func loadElements() -> [Tasks] {
        let viewContext = container.viewContext
        
        let fetchRequest = NSFetchRequest<Tasks>(entityName: "Tasks")
        do {
            let shows = try viewContext.fetch(fetchRequest)
            return shows
        } catch {
            print(error)
            return []
        }
    }
    
    func addElement(event: String) {
        let entityToAdd = Tasks(context: container.viewContext)
        entityToAdd.id = UUID()
        entityToAdd.event = event
        entityToAdd.completed = false
        
        save()
    }
    
    func update(task: Tasks) {
        task.completed.toggle()
        save()
    }
    
    func save() {
        try? container.viewContext.save()
    }
}
