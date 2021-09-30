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
    
    var sortedBy: SortedBy = .location {
        didSet {
            loadHomes()
        }
    }
    
    var homeType: HomeType = .unknown {
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
        var sortDescriptors = [NSSortDescriptor]()
        
        switch sortedBy {
        case .location:
            sortDescriptors.append(NSSortDescriptor(keyPath: \Home.city, ascending: true))
            sortDescriptors.append(NSSortDescriptor(keyPath: \Home.price, ascending: true))
        case .priceAscending:
            sortDescriptors.append(NSSortDescriptor(keyPath: \Home.price, ascending: true))
        case .priceDescending:
            sortDescriptors.append(NSSortDescriptor(keyPath: \Home.price, ascending: false))
        }
        
        var filterPredicate: NSPredicate?
        
        if homeType != .unknown {
            filterPredicate = NSPredicate(format: "%K = %@", #keyPath(Home.homeType), homeType.rawValue)
        }
        
        homes = home?.load(isForSale: isForSale, filterBy: filterPredicate, sortBy: sortDescriptors) ?? []
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
    
    func totalSoldHomesValue() -> Double {
        home?.totalSoldHomesValue() ?? 0
    }
    
    func totalSoldCondo() -> Int {
        home?.totalSoldCondo() ?? 0
    }
    
    func totalSoldSingleFamily() -> Int {
        home?.totalSoldSingleFamily() ?? 0
    }
    
    func soldPrice(priceType: String) -> Double {
        home?.soldPrice(priceType: priceType) ?? 0
    }
    
    func averageSoldPrice(for homeType: HomeType) -> Double {
        home?.averagePrice(for: homeType) ?? 0
    }
}
