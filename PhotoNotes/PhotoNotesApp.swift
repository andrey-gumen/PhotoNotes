//
//  PhotoNotesApp.swift
//  PhotoNotes
//
//  Created by Andrey Gumen on 11.12.2022.
//

import SwiftUI

@main
struct PhotoNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
