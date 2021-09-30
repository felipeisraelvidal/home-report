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
    
    @State private var sortIndex = SortedBy.location
    @State private var filterIndex = HomeType.unknown
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selectedIndex, label: Text("")) {
                    Text("For Sale").tag(HomeSegment.forSale)
                    Text("Sold").tag(HomeSegment.sold)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                .onChange(of: selectedIndex) { newValue in
                    manager.isForSale = newValue == .forSale
                }
                
                List {
                    ForEach(manager.homes, id: \.id) { home in
                        NavigationLink(
                            destination: SaleHistoryView(home: home)
                        ) {
                            HomeCellView(home: home)
                        }
                    }
                }
                .listStyle(InsetListStyle())
            }
            .navigationBarTitle("Home List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: sortMenu)
                ToolbarItem(placement: .navigationBarTrailing, content: filterMenu)
            }
        }
    }
    
    @ViewBuilder private func sortMenu() -> some View {
        Picker(selection: $sortIndex, label: Text("Sort")) {
            Text("Location")
                .tag(SortedBy.location)
            
            Text("Price Low to High")
                .tag(SortedBy.priceAscending)
            
            Text("Price High to Low")
                .tag(SortedBy.priceDescending)
        }
        .pickerStyle(MenuPickerStyle())
        .onChange(of: sortIndex) { newValue in
            manager.sortedBy = newValue
        }
    }
    
    @ViewBuilder private func filterMenu() -> some View {
        Picker(selection: $filterIndex, label: Text("Filter")) {
            Text(HomeType.singleFamily.rawValue)
                .tag(HomeType.singleFamily)
            
            Text(HomeType.condo.rawValue)
                .tag(HomeType.condo)
            
            Text(HomeType.unknown.rawValue)
                .tag(HomeType.unknown)
        }
        .pickerStyle(MenuPickerStyle())
        .onChange(of: filterIndex) { newValue in
            manager.homeType = newValue
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
