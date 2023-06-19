//
//  TasksCore.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 19/06/23.
//

import Foundation

protocol TasksCoreProtocol {
    func loadElements() -> [ViewTask]
    func addElement(name: String)
}


struct TasksCore: TasksCoreProtocol {
    func loadElements() -> [ViewTask] {
        return StorageContainer.shared.loadElements().map({ViewTask(from: $0)})
    }
    
    func addElement(name: String) {
        StorageContainer.shared.addElement(event: name)
    }
}
