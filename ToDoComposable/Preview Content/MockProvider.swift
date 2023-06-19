//
//  MockProvider.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 19/06/23.
//

import Foundation

class MockProvider: TasksCoreProtocol {
    var tasks: [ViewTask] = [
        ViewTask(id: UUID(), event: "Prova 1", completed: false),
        ViewTask(id: UUID(), event: "Prova 2", completed: true),
        ViewTask(id: UUID(), event: "Prova 3", completed: false),
        ViewTask(id: UUID(), event: "Prova 4", completed: true),
    ]
    
    func loadElements() -> [ViewTask] {
        return tasks
    }
    
    func addElement(name: String) {
        var task = ViewTask(id: UUID(), event: name, completed: false)
        tasks.append(task)
    }
    
    static func getTask() -> ViewTask {
        return ViewTask(id: UUID(), event: "Prova 1", completed: false)
    }
}
