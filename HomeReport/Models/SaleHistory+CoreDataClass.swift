//
//  SaleHistory+CoreDataClass.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//
//

import Foundation
import CoreData

@objc(SaleHistory)
public class SaleHistory: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case soldPrice, soldDate
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let userInfoContext = CodingUserInfoKey.codingUserKeyContext, let context = decoder.userInfo[userInfoContext] as? NSManagedObjectContext else {
            fatalError("Failed to get context")
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID()
        self.soldPrice = try container.decode(Double.self, forKey: .soldPrice)
        
        let dateString = try container.decode(String.self, forKey: .soldDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.soldDate = dateFormatter.date(from: dateString) ?? Date()
    }
}
