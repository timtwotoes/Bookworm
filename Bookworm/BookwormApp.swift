//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Tim on 02/05/2023.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
