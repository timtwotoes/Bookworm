//
//  ReviewExtensions.swift
//  Bookworm
//
//  Created by Tim on 02/05/2023.
//

import Foundation

extension Review {
    var reviewTitle: String {
        get {
            title ?? ""
        }
        set {
            guard managedObjectContext != nil else {
                return
            }
            title = newValue
        }
    }
    
    var reviewAuthor: String {
        get {
            author ?? ""
        }
        set {
            guard managedObjectContext != nil else {
                return
            }
            author = newValue
        }
    }
    
    var reviewText: String {
        get {
            text ?? ""
        }
        set {
            guard managedObjectContext != nil else {
                return
            }
            text = newValue
        }
    }
}
