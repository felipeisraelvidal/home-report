//
//  Home+Extension.swift
//  HomeReport
//
//  Created by Felipe Israel on 30/09/21.
//

import Foundation
import CoreData

extension Home {
    func load(isForSale: Bool) -> [Home] {
        guard let context = self.managedObjectContext else { return [] }
        
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Home.isForSale), NSNumber(value: isForSale))
        
        do {
            let homes = try context.fetch(request)
            return homes
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}
