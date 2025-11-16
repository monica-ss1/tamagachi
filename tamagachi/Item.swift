//
//  Item.swift
//  Tomagatchi But Better
//
//  Created by csuftitan on 10/22/25.
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
