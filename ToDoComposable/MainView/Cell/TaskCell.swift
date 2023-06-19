//
//  TaskCell.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 12/06/23.
//

import SwiftUI
import CoreData
import ComposableArchitecture

struct TaskCell: View {
    let store: StoreOf<TaskVM>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                if viewStore.task.completed {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color("main"))
                        .cornerRadius(6)
                        .frame(width: 28, height: 28)
                } else {
                    Rectangle()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("border"), lineWidth: 2)
                        )
                        .frame(width: 28, height: 28)
                }
                
                Text(viewStore.task.event)
                    .foregroundColor(Color("text"))
                    .font(.body)
            }.onTapGesture {
                viewStore.send(.toggleCompleted)
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        let task = MockProvider.getTask()
        TaskCell(store: Store(initialState: TaskVM.State(id: task.id, task: task), reducer: {
            TaskVM()
        }))
    }
}

