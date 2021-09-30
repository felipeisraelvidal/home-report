//
//  HomeListView.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import SwiftUI

struct HomeListView: View {
    @EnvironmentObject var manager: HomeManager
    @State private var selectedIndex = HomeSegment.forSale
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selectedIndex, label: Text("")) {
                    Text("For Sale").tag(HomeSegment.forSale)
                    Text("Sold").tag(HomeSegment.sold)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                
                List {
                    Text("Home Cell")
                }
                .listStyle(InsetListStyle())
            }
            .navigationBarTitle("Home List")
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
            .environmentObject(
                HomeManager(
                    context: PersistenceManager.preview.container.viewContext
                )
            )
    }
}
