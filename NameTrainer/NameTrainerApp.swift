//
//  NameTrainerApp.swift
//  NameTrainer
//
//  Created by Philipp Sanktjohanser on 16.01.23.
//

import SwiftUI

@main
struct NameTrainerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
