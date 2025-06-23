//
//  PersistenceController.swift
//  ToDoIos
//
//  Created by MacMy on 19.06.2025.
//

import CoreData

/// Класс для хранения информации о подключении к базе данных
final class PersistenceController: Sendable {
  static let shared = PersistenceController()
  
///  @MainActor Для 5.5 и выше не работает
  static let preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    let item = TodoItem(context: viewContext)
    
    item.title = "Купить молока"
    item.id = UUID()
    item.isCompleted = false
    item.priority = 1
    
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    
    return result
  }()
  
  let container : NSPersistentContainer
  
  /// Конструктор
  /// - Parameters:
  ///  - inMemory: Использовать данные в памяти. По умолчанию "Использовать"
  private init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Model")
    
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    
    printPathDb()
    
    container.loadPersistentStores{storeDesctription, error in
      if let error = error {
        fatalError("Unresolved error \(error)")
      } else {
        //Альтернативный способ получения путь к БД
        /*if let url = storeDesctription.url {
          print("path to DB = \(url.path)")
        } else {
          print("path to DB not find")
        }*/
      }
    }
  }
  
  /// Вывод информации о расположении БД
  private func printPathDb() {
    if let storeUrl = container.persistentStoreDescriptions.first?.url {
      print("path to DB: \(storeUrl.path)")
    } else {
      print("path to DB not find")
    }
  }
}
