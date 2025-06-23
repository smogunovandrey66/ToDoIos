//
//  TodoListView.swift
//  ToDoIos
//
//  Created by MacMy on 20.06.2025.
//

import SwiftUI

struct TodoListView:View {
  @StateObject var viewModel = TodoViewModel()
  @State private var showingAddView = false
  
  var body: some View {
    NavigationView{
      List {
        ForEach(viewModel.todos) { todo in
          TodoRowView(todo: todo, viewModel: viewModel)
        }
        .onDelete{ indexSet in
          indexSet.forEach{index in
            viewModel.delete(index)
          }
        }
      }
      .navigationTitle("TODOs")
      .toolbar{
        Button{
          showingAddView.toggle()
        } label: {
          Image(systemName: "plus")
        }
      }
      .sheet(isPresented: $showingAddView) {
        AddEditTodoView(viewModel: viewModel)
      }
    }
  }
}


#Preview {
  TodoListView(viewModel: TodoViewModel(inMemory: true))
}
