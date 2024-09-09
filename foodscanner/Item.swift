//
//  Item.swift
//  foodscanner
//
//  Created by felipe ivan on 09/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
