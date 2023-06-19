//
//  TaskViewModel.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 19/06/23.
//

import Foundation
import ComposableArchitecture

struct TaskVM: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id: UUID
        var task: ViewTask
    }
    
    enum Action: Equatable {
         case toggleCompleted
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .toggleCompleted:
            state.task.completed.toggle()
            if let task = state.task.task {
                task.completed.toggle()
                StorageContainer.shared.update(task: task)
            }
            return .none
        }
    }
}
