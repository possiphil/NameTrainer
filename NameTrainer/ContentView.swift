//
//  ContentView.swift
//  NameTrainer
//
//  Created by Philipp Sanktjohanser on 16.01.23.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var imageIDs: FetchedResults<Images>
    
    @State private var images = [ImageWithName]()
    @State private var name = ""
    @State private var image: UIImage?
    @State private var showImagePicker = false
    @State private var showNamePicker = false
    
    private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(images, id: \.self) { image in
                    NavigationLink {
                        DetailView(image: Image(uiImage: UIImage(data: image.data) ?? UIImage()), name: image.name, location: CLLocationCoordinate2D(latitude: image.latitude, longitude: image.longitude))
                    } label: {
                        HStack {
                            Image(uiImage: UIImage(data: image.data) ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                            Text(image.name)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                loadImage()
                self.locationFetcher.start()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $image)
            }
            .onChange(of: image) { newValue in
                if newValue != nil {
                    showNamePicker.toggle()
                }
            }
            .alert("Pick a name", isPresented: $showNamePicker) {
                TextField("Name", text: $name)
                
                Button("Confirm", role: .cancel) { saveImage() }
            }
        }
    }
    
    func saveImage() {
        if image != nil && name != "" {
            if let jpegData = image?.jpegData(compressionQuality: 0.8) {
                let id = UUID()
                readLocation()
                try? jpegData.write(to: path.appending(path: "\(id).jpeg"), options: [.atomic, .completeFileProtection])
                
                let newImage = Images(context: moc)
                newImage.id = id
                newImage.name = name
                newImage.latitude = locationFetcher.lastKnownLocation?.latitude ?? 25.0
                newImage.longitude = locationFetcher.lastKnownLocation?.longitude ?? 25.0
                try? moc.save()
                
                loadImage()
            }
        }
    }
    
    func loadImage() {
        for imageID in imageIDs {
            let image = try? Data(contentsOf: path.appending(path: "\(imageID.id!).jpeg"))
            let imageWithName = ImageWithName(name: imageID.name ?? "", data: image ?? Data(), latitude: imageID.latitude, longitude: imageID.longitude)
            if !images.contains(imageWithName) {
                images.append(imageWithName)
            }
        }
    }
    
    func readLocation() {
        if let location = self.locationFetcher.lastKnownLocation {
            print("Your location is \(location)")
        } else {
            print("Your location is unknown")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
