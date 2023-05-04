//
//  NoteCoreDataApp.swift
//  NoteCoreData
//
//  Created by Filip Hertzman on 2023-03-09.
//

import SwiftUI

@main
struct NoteCoreDataApp: App {
    
    @StateObject private var CoreDataVm = CoreDateViewModel()
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CoreDataVm)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
