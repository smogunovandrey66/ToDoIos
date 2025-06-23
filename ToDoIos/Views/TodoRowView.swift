//
//  TodoRowView.swift
//  ToDoIos
//
//  Created by MacMy on 20.06.2025.
//

import SwiftUI

struct TodoRowView: View {
  @ObservedObject var todo: TodoItem
  let viewModel: TodoViewModel

  var body: some View {
    HStack {
      Button(action: {
        print("click")
        viewModel.toogleComplete(todo)
      }) {
        let _ = print("create image®")
        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : 	"circle")
          .foregroundColor(todo.isCompleted ? .green : .gray)
      }
      
      Text(todo.title ?? "Empty name")
        .strikethrough(todo.isCompleted)
      
      Spacer().border(Color.red, width: 1)
    }
  }
}

#Preview("test") {
  HStack{
    Image(systemName: "checkmark.circle.fill").border(Color.red, width: 2)
    Image(systemName: "fill").foregroundColor(Color.yellow).border(Color.red, width: 3)
    Image(systemName: "fill")
        .font(.system(size: 50))
        .foregroundColor(.blue)
    Image(systemName: "checkmark.circle.fill").border(Color.red, width: 2)
  }
}

#Preview("View TodoRowView") {
  let modelView = TodoViewModel(inMemory: true)
  TodoRowView(todo: modelView.todos[0], viewModel: modelView)
}


