//
//  SaleHistoryView.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import SwiftUI

struct SaleHistoryView: View {
    @EnvironmentObject private var manager: HomeManager
    
    var home: Home
    
    var body: some View {
        VStack(spacing: 50) {
            Group {
                if let imageData = home.image, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                } else {
                    Image(systemName: "house.circle")
                }
            }
            .clipShape(Circle().inset(by: 5))
            .overlay(Circle().stroke(Color.gray, lineWidth: 4))
            .shadow(radius: 10)
            
            List(manager.saleHistory(for: home), id: \.id) { history in
                HStack {
                    Text(history.soldDate.toString)
                    Spacer()
                    Text(history.soldPrice.currency)
                }
            }
            .listStyle(InsetListStyle())
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}

struct SaleHistoryView_Previews: PreviewProvider {
    private static var home: Home = {
        let home = Home(context: PersistenceManager.preview.container.viewContext)
        home.id = UUID()
        return home
    }()
    
    static var previews: some View {
        SaleHistoryView(home: home)
            .environmentObject(
                HomeManager(
                    context: PersistenceManager.preview.container.viewContext
                )
            )
    }
}
