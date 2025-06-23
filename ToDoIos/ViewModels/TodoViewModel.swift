//
//  TodoViewModel.swift
//  ToDoIos
//
//  Created by MacMy on 19.06.2025.
//

import Foundation
import CoreData

class TodoViewModel: ObservableObject {
  @Published var todos: [TodoItem] = []

  private let context: NSManagedObjectContext

  init(inMemory: Bool = false) {
    if inMemory {
      context = PersistenceController.preview.container.viewContext
    } else {
      context = PersistenceController.shared.container.viewContext
    }
    fetchTodos()
  }

  private func fetchTodos() {
    let request = TodoItem.fetchRequest()

    request.sortDescriptors = [
      NSSortDescriptor(key: "timestamp", ascending: true)
    ]

    do {
      todos = try context.fetch(request)
    } catch {
      print("Fetch error: \(error)")
    }
  }

  private func save() {
    do {
      try context.save()
      fetchTodos()
    } catch {
      print("Save error: \(error)")
    }
  }

  func addTodo(title: String, dueDate: Date?, priority: Int16) {
    let todo = TodoItem(context: context)
    todo.id = UUID()
    todo.title = title
    todo.dueDate = dueDate
    todo.isCompleted = false
    todo.priority = priority
    todo.timestamp = Date()

    save()
  }

  func toogleComplete(_ todo: TodoItem) {
    todo.isCompleted.toggle()
    save()
  }

  func delete(_ todo: TodoItem) {
    context.delete(todo)
    save()
  }

  func delete(_ index: Int) {
    delete(todos[index])
  }
}
