//
//  AddEditTodoView.swift
//  ToDoIos
//
//  Created by MacMy on 20.06.2025.
//

import SwiftUI

struct AddEditTodoView: View {
  @Environment(\.presentationMode) var presentaionMode
  @ObservedObject var viewModel: TodoViewModel

  @State private var title = ""
  @State private var dueDate = Date()
  @State private var priority: Int16 = 1

  var body: some View {
    NavigationView {
      Form {
        TextField("Title", text: $title)
        DatePicker("Due date", selection: $dueDate)
        Stepper("Priority: \(priority)", value: $priority, in: 1...5)
      }
      .navigationTitle("New Task")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Save") {
            viewModel.addTodo(
              title: title, dueDate: dueDate, priority: priority)
            presentaionMode.wrappedValue.dismiss()
          }
        }

        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            presentaionMode.wrappedValue.dismiss()
          }
        }
      }
    }
  }
}
