//
//  ToDoComposableApp.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 06/06/23.
//

import SwiftUI
import ComposableArchitecture
import Combine

@main
struct ToDoComposableApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(vm: Store(initialState: MainViewModel.State()) {
                MainViewModel(loadElements: {
                    return StorageContainer.shared.loadElements()
                })
            })
        }
    }
}
