//
//  ToDoComposableTests.swift
//  ToDoComposableTests
//
//  Created by Fabio Cirruto on 14/06/23.
//
import ComposableArchitecture
import XCTest

final class ToDoComposableTests: XCTestCase {

    func testShowHideForm() {
        let store = TestStore(initialState: MainViewModel.State()) {
            MainViewModel(loadElements: { return [] })
        }
        
        store.send(.showHideForm) {
            $0.showForm = true
        }
    }
    
    func testLoadElement() {
        let store = TestStore(initialState: MainViewModel.State()) {
            MainViewModel(loadElements: { return [] })
        }
        
        store.send(.loadElement)
    }
    
    func testAddElement() {
        let store = TestStore(initialState: MainViewModel.State()) {
            MainViewModel(loadElements: { return [] })
        }
        
        store.send(.showHideForm) {
            $0.showForm = true
        }
        
        store.send(.addElement("Prova da test"))
        
        store.receive(.showHideForm) {
            $0.showForm = false
        }
        
        store.receive(.loadElement)
    }
}
