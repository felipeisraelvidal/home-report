//
//  PersistenceManager.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import Foundation

import Foundation
import CoreData

struct PersistenceManager {
    let container: NSPersistentContainer
    
    static var preview: PersistenceManager = {
        let result = PersistenceManager(inMemory: true)
        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "HomeReport")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        checkData()
    }
    
    private func checkData() {
        let context = container.viewContext
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        
        if let homeCount = try? context.count(for: request), homeCount > 0 {
            return
        }
        
        uploadSampleData()
    }
    
    private func uploadSampleData() {
        guard let url = Bundle.main.url(forResource: "homes", withExtension: "json"), let data = try? Data(contentsOf: url), let codingUserKeyContext = CodingUserInfoKey.codingUserKeyContext else { return }
        
        do {
            let context = container.viewContext
            let decoder = JSONDecoder()
            
            decoder.userInfo[codingUserKeyContext] = context
            _ = try decoder.decode([Home].self, from: data)
        } catch let error {
            print(error)
        }
    }
}
