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
    
    let loadElements: () -> [Tasks]
    
    struct State: Equatable {
        var showForm: Bool = false
        var buttonIcon: String {
            showForm ? "minus" : "plus"
        }
        var tasks: [Tasks] = []
    }
    
    enum Action: Equatable {
        case showHideForm
        case loadElement
        case addElement(String)
        case toggleCompleted(Tasks)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .showHideForm:
            state.showForm.toggle()
            return .none
        case .loadElement:
            state.tasks = loadElements()
            return .none
        case .addElement(let name):
            StorageContainer.shared.addElement(event: name)
            let effects: [EffectTask<MainViewModel.Action>] = [EffectTask(value: .showHideForm), EffectTask(value: .loadElement)]
            return .concatenate(effects)
        case .toggleCompleted(let task):
            StorageContainer.shared.update(task: task)
            //StorageContainer.shared.container.viewContext.reset()
            return EffectTask(value: .loadElement)
        }
    }
}
