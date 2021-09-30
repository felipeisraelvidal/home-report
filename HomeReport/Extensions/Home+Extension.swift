//
//  Home+Extension.swift
//  HomeReport
//
//  Created by Felipe Israel on 30/09/21.
//

import Foundation
import CoreData

extension Home {
    func load(isForSale: Bool, filterBy filter: NSPredicate?, sortBy sort: [NSSortDescriptor]) -> [Home] {
        guard let context = self.managedObjectContext else { return [] }
        
        let request: NSFetchRequest<Home> = Home.fetchRequest()
//        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Home.isForSale), NSNumber(value: isForSale))
        
        var predicates = [NSPredicate]()
        let statusPredicate = self.statusPredicate(isForSale: isForSale)
        predicates.append(statusPredicate)
        
        if let additionalPredicate = filter {
            predicates.append(additionalPredicate)
        }
        
        let predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        request.predicate = predicate
        
        request.sortDescriptors = sort.isEmpty ? nil : sort
        
        do {
            let homes = try context.fetch(request)
            return homes
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func totalSoldHomesValue() -> Double {
        guard let context = self.managedObjectContext else { return 0 }
        
        let reportName = "totalSales"
        
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        request.predicate = statusPredicate()
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = reportName
        sumExpressionDescription.expression = NSExpression(
            forFunction: "sum:",
            arguments: [
                NSExpression(
                    forKeyPath: #keyPath(Home.price)
                )
            ]
        )
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        if let request = request as? NSFetchRequest<NSFetchRequestResult>, let results = try? context.fetch(request) as? [NSDictionary], let totalSales = results.first?[reportName] as? Double {
            return totalSales
        }
        
        return 0
    }
    
    func totalSoldCondo() -> Int {
        guard let context = self.managedObjectContext else { return 0 }
        
        let soldPredicate = statusPredicate()
        let typePredicate = homeTypePredicate(for: .condo)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [soldPredicate, typePredicate])
        
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        request.predicate = predicate
        request.resultType = .countResultType
        
        if let request = request as? NSFetchRequest<NSFetchRequestResult>, let results = try? context.fetch(request) as? [Int], let count = results.first {
            return count
        }
        
        return 0
    }
    
    func totalSoldSingleFamily() -> Int {
        guard let context = self.managedObjectContext else { return 0 }
        
        let soldPredicate = statusPredicate()
        let typePredicate = homeTypePredicate(for: .singleFamily)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [soldPredicate, typePredicate])
        
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        request.predicate = predicate
        
        if let count = try? context.count(for: request), count != NSNotFound {
            return count
        }
        
        return 0
    }
    
    func soldPrice(priceType: String) -> Double { // "min" or "max"
        guard let context = self.managedObjectContext else { return 0 }
        
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        request.predicate = statusPredicate()
        request.resultType = .dictionaryResultType
        
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "priceType"
        expressionDescription.expression = NSExpression(
            forFunction: "\(priceType):",
            arguments: [
                NSExpression(
                    forKeyPath: #keyPath(Home.price)
                )
            ]
        )
        expressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [expressionDescription]
        
        if let request = request as? NSFetchRequest<NSFetchRequestResult>,
           let results = try? context.fetch(request) as? [NSDictionary],
           let homePrice = results.first?["priceType"] as? Double {
            return homePrice
        }
        
        return 0
    }
    
    func averagePrice(for homeType: HomeType) -> Double {
        guard let context = self.managedObjectContext else { return 0 }
        
        let soldPredicate = statusPredicate()
        let typePredicate = homeTypePredicate(for: homeType)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [soldPredicate, typePredicate])
        
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        request.predicate = predicate
        request.resultType = .dictionaryResultType
        
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = homeType.rawValue
        expressionDescription.expression = NSExpression(
            forFunction: "average:",
            arguments: [
                NSExpression(
                    forKeyPath: #keyPath(Home.price)
                )
            ]
        )
        expressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [expressionDescription]
        
        if let request = request as? NSFetchRequest<NSFetchRequestResult>,
            let results = try? context.fetch(request) as? [NSDictionary],
            let homePrice = results.first?[homeType.rawValue] as? Double {
            return homePrice
        }
        
        return 0
    }
}

extension Home {
    func statusPredicate(isForSale: Bool = false) -> NSPredicate {
        return NSPredicate(format: "%K = %@", #keyPath(Home.isForSale), NSNumber(value: isForSale))
    }
    
    func homeTypePredicate(for homeType: HomeType) -> NSPredicate {
        return NSPredicate(format: "%K = %@", #keyPath(Home.homeType), homeType.rawValue)
    }
}
