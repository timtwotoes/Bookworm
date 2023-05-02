//
//  ContentView.swift
//  Bookworm
//
//  Created by Tim on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationSplitView {
            ListingView()
                .frame(minWidth: 250)
        } detail: {
            if let selectedReview = dataController.selectedReview {
                ReviewDetailView(review: selectedReview)
            } else {
                Text("Please select review")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
