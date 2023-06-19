//
//  ViewTask.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 19/06/23.
//

import Foundation

struct ViewTask: Equatable {
    let id: UUID
    let event: String
    var completed: Bool
    var task: Tasks?
    
    init(id: UUID, event: String, completed: Bool, task: Tasks? = nil) {
        self.id = id
        self.event = event
        self.completed = completed
        self.task = task
    }
    
    init(from: Tasks) {
        self.id = from.id ?? UUID()
        self.event = from.event ?? ""
        self.completed = from.completed
        self.task = from
    }
}
