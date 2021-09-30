//
//  SingleFamily+CoreDataProperties.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//
//

import Foundation
import CoreData


extension SingleFamily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleFamily> {
        return NSFetchRequest<SingleFamily>(entityName: "SingleFamily")
    }

    @NSManaged public var lotSize: Int16

}
