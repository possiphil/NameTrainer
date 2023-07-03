//
//  Location.swift
//  NameTrainer
//
//  Created by Philipp Sanktjohanser on 17.01.23.
//

import CoreLocation
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let image: Image
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
