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
                        Text("$$$")
                    }
                    
                    HStack {
                        Text("# of Condo sold")
                        Spacer()
                        Text("999")
                    }
                    
                    HStack {
                        Text("# of SF sold")
                        Spacer()
                        Text("999")
                    }
                }
                
                Section {
                    HStack {
                        Text("Min home price")
                        Spacer()
                        Text("$$$")
                    }
                    
                    HStack {
                        Text("Max home price")
                        Spacer()
                        Text("$$$")
                    }
                }
                
                Section {
                    HStack {
                        Text("Avg condo price")
                        Spacer()
                        Text("$$$")
                    }
                    
                    HStack {
                        Text("Avg SF price")
                        Spacer()
                        Text("$$$")
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
