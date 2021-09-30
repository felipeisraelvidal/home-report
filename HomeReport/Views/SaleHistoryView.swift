//
//  SaleHistoryView.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import SwiftUI

struct SaleHistoryView: View {
    @EnvironmentObject private var manager: HomeManager
    
    var body: some View {
        VStack(spacing: 50) {
            Group {
                Image(systemName: "house.circle")
            }
            .clipShape(Circle().inset(by: 5))
            .overlay(Circle().stroke(Color.gray, lineWidth: 4))
            .shadow(radius: 10)
            
            List {
                HStack {
                    Text("Sold Date")
                    Spacer()
                    Text("$$$")
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}

struct SaleHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SaleHistoryView()
            .environmentObject(
                HomeManager(
                    context: PersistenceManager.preview.container.viewContext
                )
            )
    }
}
