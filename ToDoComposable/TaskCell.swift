//
//  TaskCell.swift
//  ToDoComposable
//
//  Created by Fabio Cirruto on 12/06/23.
//

import SwiftUI
import CoreData

struct TaskCell: View {
    
    var task: Tasks
    
    var body: some View {
        HStack {
            if task.completed {
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
            
            Text(task.event ?? "")
                .foregroundColor(Color("text"))
                .font(.body)
        }
    }
}
