//
//  ListingView.swift
//  Bookworm
//
//  Created by Tim on 02/05/2023.
//

import SwiftUI

struct ListingView: View {
    @AppStorage("id") var id = 1
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var reviews: FetchedResults<Review>
    
    var body: some View {
        List(reviews, selection: $dataController.selectedReview) { review in
            Text(review.reviewTitle)
                .tag(review)
        }
        .toolbar {
            Button(action: addReview) {
                Label("Add Review", systemImage: "plus")
            }
            Button(action: deleteSelectedReview) {
                Label("Delete", systemImage: "trash")
            }
            .disabled(dataController.selectedReview == nil)
        }
        .onDeleteCommand(perform: deleteSelectedReview)
        .contextMenu {
            Button("Delete", role: .destructive, action: deleteSelectedReview)
        }
    }
    
    func addReview() {
        let review = Review(context: managedObjectContext)
        review.id = Int32(id)
        review.title = "Enter the title"
        review.author = "Enther name of author"
        review.rating = 3
        
        id += 1
        dataController.save()
        dataController.selectedReview = review
    }
    
    func deleteSelectedReview() {
        guard let selectedReview = dataController.selectedReview else {
            return
        }
        
        guard let selectedIndex = reviews.firstIndex(of: selectedReview) else {
            return
        }
        
        managedObjectContext.delete(selectedReview)
        try? managedObjectContext.save()
        
        if selectedIndex < reviews.count {
            dataController.selectedReview = reviews[selectedIndex]
        } else {
            let previousIndex = selectedIndex - 1
            
            if previousIndex >= 0 {
                dataController.selectedReview = reviews[previousIndex]
            }
        }
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
