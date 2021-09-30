//
//  Home+CoreDataProperties.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//
//

import Foundation
import CoreData


extension Home {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Home> {
        return NSFetchRequest<Home>(entityName: "Home")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var bath: Int16
    @NSManaged public var bed: Int16
    @NSManaged public var city: String
    @NSManaged public var homeType: String
    @NSManaged public var image: Data?
    @NSManaged public var isForSale: Bool
    @NSManaged public var price: Double
    @NSManaged public var sqft: Int16
    @NSManaged public var saleHistories: NSSet?

}

// MARK: Generated accessors for saleHistories
extension Home {

    @objc(addSaleHistoriesObject:)
    @NSManaged public func addToSaleHistories(_ value: SaleHistory)

    @objc(removeSaleHistoriesObject:)
    @NSManaged public func removeFromSaleHistories(_ value: SaleHistory)

    @objc(addSaleHistories:)
    @NSManaged public func addToSaleHistories(_ values: NSSet)

    @objc(removeSaleHistories:)
    @NSManaged public func removeFromSaleHistories(_ values: NSSet)

}

extension Home : Identifiable {

}
