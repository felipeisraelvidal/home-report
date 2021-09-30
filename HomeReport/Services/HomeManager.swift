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
    
    private let _context: NSManagedObjectContext
    private let home: Home?
    
    init(context: NSManagedObjectContext) {
        self._context = context
        self.home = Home(context: context)
        
        loadHomes()
    }
    
    private func loadHomes() {
        homes = home?.load(isForSale: isForSale) ?? []
    }
}
