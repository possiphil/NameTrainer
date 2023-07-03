//
//  Image.swift
//  NameTrainer
//
//  Created by Philipp Sanktjohanser on 16.01.23.
//

import Foundation

struct ImageWithName: Hashable, Comparable {
    let name: String
    let data: Data
    let latitude: Double
    let longitude: Double
    
    static func <(lhs: ImageWithName, rhs: ImageWithName) -> Bool {
        return lhs.name < rhs.name
    }
}
