//
//  MainView.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 06/06/23.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @State private var name: String = ""
    let vm: StoreOf<MainViewModel>
    
    var list: some View {
        ForEachStore(
          self.vm.scope(state: \.tasks, action: MainViewModel.Action.task(state:action:))
        ) {
          TaskCell(store: $0)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
    }
    
    var body: some View {
        WithViewStore(self.vm, observe: { $0 }) { vm in
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    Color("background").ignoresSafeArea()
                    
                    VStack {
                        if vm.showForm {
                            VStack {
                                TextField("Inserisci task", text: $name)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 21)
                                            .strokeBorder(Color("border"), lineWidth: 1)
                                    )
                                
                                Button {
                                    vm.send(.addElement(name))
                                    name = ""
                                } label: {
                                    Text("SALVA")
                                        .foregroundColor(.white)
                                        .bold()
                                        .frame(height: 45)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(Color("main"))
                                        .cornerRadius(21)
                                }
                                
                                Divider()
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        List {
                            list
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)
                    }
                    
                    Button {
                        vm.send(.showHideForm, animation: .easeInOut)
                    } label: {
                        Image(systemName: vm.buttonIcon)
                            .padding()
                            .frame(width: 42, height: 42)
                            .background(Color("main"))
                            .cornerRadius(21)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .navigationTitle("To Do")
            }.onAppear {
                vm.send(.loadElement)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: Store(initialState: MainViewModel.State()) {
            MainViewModel(taskCore: MockProvider())
        })
    }
}
