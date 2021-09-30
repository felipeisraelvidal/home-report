//
//  SummaryView.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject private var manager: HomeManager
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Total home sales")
                        Spacer()
                        Text(manager.totalSoldHomesValue().currency)
                    }
                    
                    HStack {
                        Text("# of Condo sold")
                        Spacer()
                        Text("\(manager.totalSoldCondo())")
                    }
                    
                    HStack {
                        Text("# of SF sold")
                        Spacer()
                        Text("\(manager.totalSoldSingleFamily())")
                    }
                }
                
                Section {
                    HStack {
                        Text("Min home price")
                        Spacer()
                        Text(manager.soldPrice(priceType: "min").currency)
                    }
                    
                    HStack {
                        Text("Max home price")
                        Spacer()
                        Text(manager.soldPrice(priceType: "max").currency)
                    }
                }
                
                Section {
                    HStack {
                        Text("Avg condo price")
                        Spacer()
                        Text(manager.averageSoldPrice(for: .condo).currency)
                    }
                    
                    HStack {
                        Text("Avg SF price")
                        Spacer()
                        Text(manager.averageSoldPrice(for: .singleFamily).currency)
                    }
                }
            }
            .navigationBarTitle("Sold Homes")
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
            .environmentObject(
                HomeManager(
                    context: PersistenceManager.preview.container.viewContext
                )
            )
    }
}
