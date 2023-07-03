//
//  DetailView.swift
//  NameTrainer
//
//  Created by Philipp Sanktjohanser on 17.01.23.
//

import MapKit
import SwiftUI

struct DetailView: View {
    let image: Image
    let name: String
    let location: CLLocationCoordinate2D
    
    @State private var mapRegion: MKCoordinateRegion
    @State private var locations: [Location]
    
    init(image: Image, name: String, location: CLLocationCoordinate2D) {
        self.image = image
        self.name = name
        self.location = location
        self.locations = [Location(name: name, image: image, latitude: location.latitude, longitude: location.longitude)]
        mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    }
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    Text(name)
                }
            }
        }
        
//        VStack {
//            image
//                .resizable()
//                .scaledToFit()
//            Text(name)
//        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
