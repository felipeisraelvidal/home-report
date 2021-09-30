//
//  HomeCellView.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import SwiftUI

struct HomeCellView: View {
    var home: Home
    
    var body: some View {
        HStack {
            Group {
                if let imageData = home.image, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    Image(systemName: "house.circle")
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 75, height: 50)
            .clipped()
            .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text("\(home.city) - \(home.homeType)")
                    .font(.subheadline)
                
                HStack(spacing: 20) {
                    VStack {
                        Text(home.isForSale ? "Current Price" : "Sold Price")
                        Text(home.price.currency)
                    }
                    
                    VStack {
                        Text("Bed")
                        Text("\(home.bed)")
                    }
                    
                    VStack {
                        Text("Bath")
                        Text("\(home.bath)")
                    }
                    
                    VStack {
                        Text("SqFt")
                        Text("\(home.sqft)")
                    }
                }
                .font(.caption2)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct HomeCellView_Previews: PreviewProvider {
    private static var home: Home = {
        let home = Home(context: PersistenceManager.preview.container.viewContext)
        home.id = UUID()
        return home
    }()
    
    static var previews: some View {
        HomeCellView(home: home)
    }
}
