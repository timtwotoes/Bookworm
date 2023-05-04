//
//  ReviewDetailView.swift
//  Bookworm
//
//  Created by Tim on 02/05/2023.
//

import SwiftUI

struct ReviewDetailView: View {
    @ObservedObject var review: Review
    @EnvironmentObject var dataController: DataController
    @State private var showingRendered = false
    
    var body: some View {
        Form {
            TextField("Title", text: $review.reviewTitle)
            TextField("Author", text: $review.reviewAuthor)
            
            Picker("Rating", selection: $review.rating) {
                ForEach(1..<6) {
                    Text(String($0))
                        .tag(Int32($0))
                }
            }
            .pickerStyle(.segmented)
            
            TextEditor(text: $review.reviewText)
        }
        .onChange(of: review.reviewTitle, perform: dataController.enqueueSave)
        .onChange(of: review.reviewAuthor, perform: dataController.enqueueSave)
        .onChange(of: review.reviewText, perform: dataController.enqueueSave)
        .onChange(of: review.rating, perform: dataController.enqueueSave)
        .disabled(review.managedObjectContext == nil)
        .toolbar {
            Button {
                showingRendered = true
            } label: {
                Label("Show rendered", systemImage: "book")
            }
        }
        .sheet(isPresented: $showingRendered) {
            RenderView(review: review)
        }
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let dataController = DataController()
        let review = Review(context: dataController.container.viewContext)
        
        ReviewDetailView(review: review)
            .environmentObject(dataController)
    }
}
