//
//  Date+Extension.swift
//  HomeReport
//
//  Created by Felipe Israel on 30/09/21.
//

import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: self)
    }
}
