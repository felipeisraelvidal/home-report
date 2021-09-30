//
//  Double+Extension.swift
//  HomeReport
//
//  Created by Felipe Israel on 30/09/21.
//

import Foundation

extension Double {
    var currency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
