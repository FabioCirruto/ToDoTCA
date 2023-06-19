//
//  ToDoComposableTests.swift
//  ToDoComposableTests
//
//  Created by Fabio Cirruto on 14/06/23.
//
import ComposableArchitecture
import XCTest
@testable import ToDoComposable

final class ToDoComposableTests: XCTestCase {
    
    func testShowHideForm() {
        let store = TestStore(
          initialState: MainViewModel.State(),
          reducer: MainViewModel(taskCore: MockProvider())
        )
        
        store.send(.showHideForm) {
            $0.showForm = true
        }
    }
    
    func testLoadElement() {
        let provider = MockProvider()
       let store = TestStore(
          initialState: MainViewModel.State(),
          reducer: MainViewModel(taskCore: provider)
        )
        
        store.send(.loadElement) {
            var tasks: IdentifiedArrayOf<TaskVM.State> = []
            for task in provider.tasks {
                tasks.append(TaskVM.State(id: task.id, task: task))
            }
            $0.tasks = tasks
        }
    }
    
    func testAddElement() {
        let provider = MockProvider()
        let store = TestStore(
          initialState: MainViewModel.State(),
          reducer: MainViewModel(taskCore: provider)
        )
        
        store.send(.showHideForm) {
            $0.showForm = true
        }
        
        store.send(.addElement("Prova da test"))
        
        store.receive(.showHideForm) {
            $0.showForm = false
        }
        
        store.receive(.loadElement) {
            var tasks: IdentifiedArrayOf<TaskVM.State> = []
            for task in provider.tasks {
                tasks.append(TaskVM.State(id: task.id, task: task))
            }
            $0.tasks = tasks
        }
    }
    
    func testToggleCompleted() {
        let task = MockProvider.getTask()
        let store = TestStore(initialState: TaskVM.State(id: task.id, task: task)) {
            TaskVM()
        }
        
        store.send(.toggleCompleted) {
            $0.task.completed = true
        }
    }
}
