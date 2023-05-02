//
//  DataController.swift
//  Bookworm
//
//  Created by Tim on 02/05/2023.
//

import Foundation
import CoreData

public class DataController: ObservableObject {
    private let container = NSPersistentContainer(name: "Bookworm")
    private var saveTask: Task<Void, Error>?
    
    public init() {
        container.loadPersistentStores { description, error in
            print("Core data failed to load: \(error?.localizedDescription)")
        }
    }
    
    public func save() {
        guard container.viewContext.hasChanges else {
            return
        }
        try? container.viewContext.save()
    }
    
    public func enqueueSave(_ change: Any) {
        saveTask?.cancel()
        
        saveTask = Task { @MainActor in
            try await Task.sleep(for: .seconds(5))
            save()
        }
    }
}