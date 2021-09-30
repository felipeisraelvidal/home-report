//
//  Home+CoreDataClass.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//
//

import Foundation
import CoreData
import UIKit

enum HomeType: String {
    case condo = "Condo"
    case singleFamily = "Single Family"
}

@objc(Home)
public class Home: NSManagedObject, Decodable {
    private struct Category: Decodable {
        var homeType: String
    }
    
    private struct Status: Decodable {
        var isForSale: Bool
    }
    
    enum CodingKeys: CodingKey {
        case bed, bath, city, image, price, sqft, homeType, category, status, unitsPerBuilding, lotSize, saleHistory
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let userInfoContext = CodingUserInfoKey.codingUserKeyContext, let context = decoder.userInfo[userInfoContext] as? NSManagedObjectContext else {
            fatalError("Failed to get context")
        }
        
        self.init(context: context)
        
        // We need to rollback the Home data since we will be using either Condo or SingleFamily type object
        context.rollback()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let type = try container.decode(Category.self, forKey: .category).homeType
        let home = HomeType(rawValue: type) == .condo ? Condo(context: context) : SingleFamily(context: context)
        
        home.id = UUID()
        home.city = try container.decode(String.self, forKey: .city)
        home.price = try container.decode(Double.self, forKey: .price)
        home.bed = try container.decode(Int16.self, forKey: .bed)
        home.bath = try container.decode(Int16.self, forKey: .bath)
        home.sqft = try container.decode(Int16.self, forKey: .sqft)
        home.homeType = type
        home.isForSale = try container.decode(Status.self, forKey: .status).isForSale
        home.saleHistories = try container.decode(Set<SaleHistory>.self, forKey: .saleHistory) as NSSet
        
        if home is Condo {
            (home as! Condo).unitsPerBuilding = try container.decode(Int16.self, forKey: .unitsPerBuilding)
        } else if home is SingleFamily {
            (home as! SingleFamily).lotSize = try container.decode(Int16.self, forKey: .lotSize)
        }
        
        if let imageName = try container.decodeIfPresent(String.self, forKey: .image), let image = UIImage(named: imageName), let imageData = image.jpegData(compressionQuality: 1) {
            home.image = imageData
        }
        
        try? context.save()
    }
}
