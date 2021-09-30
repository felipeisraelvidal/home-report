//
//  HomeManager.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import Foundation
import CoreData

enum HomeSegment: Int {
    case forSale = 0
    case sold
}

enum SortedBy: Int {
    case location = 0
    case priceAscending
    case priceDescending
}

class HomeManager: ObservableObject {
    @Published var homes = [Home]()
    
    var isForSale: Bool = true {
        didSet {
            loadHomes()
        }
    }
    
    private let context: NSManagedObjectContext
    private let home: Home?
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.home = Home(context: context)
        
        loadHomes()
    }
    
    private func loadHomes() {
        homes = home?.load(isForSale: isForSale) ?? []
    }
    
    func saleHistory(for home: Home) -> [SaleHistory] {
        let request: NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(SaleHistory.home), home)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \SaleHistory.soldDate, ascending: false)
        ]
        
        do {
            let saleHistory = try context.fetch(request)
            return saleHistory
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
