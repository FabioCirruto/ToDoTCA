//
//  MainViewModel.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 07/06/23.
//

import ComposableArchitecture
import SwiftUI
import Dependencies
import CoreData

struct MainViewModel: ReducerProtocol {
    
    let taskCore: TasksCoreProtocol
    
    struct State: Equatable {
        var showForm: Bool = false
        var buttonIcon: String {
            showForm ? "minus" : "plus"
        }
        var tasks: IdentifiedArrayOf<TaskVM.State> = []
    }
    
    enum Action: Equatable {
        case showHideForm
        case loadElement
        case addElement(String)
        case task(state: TaskVM.State.ID, action: TaskVM.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .showHideForm:
                state.showForm.toggle()
                return .none
            case .loadElement:
                for task in taskCore.loadElements() {
                    state.tasks.append(TaskVM.State(id: task.id, task: task))
                }
                return .none
            case .addElement(let name):
                taskCore.addElement(name: name)
                let effects: [EffectTask<MainViewModel.Action>] = [EffectTask(value: .showHideForm), EffectTask(value: .loadElement)]
                return .concatenate(effects)
            case .task(state: _, action: _):
                return .none
            }
        }
        .forEach(\.tasks, action: /Action.task(state:action:)) {
          TaskVM()
        }
    }
}
