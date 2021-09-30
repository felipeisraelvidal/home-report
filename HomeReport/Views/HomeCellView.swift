//
//  HomeCellView.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import SwiftUI

struct HomeCellView: View {
    var body: some View {
        HStack {
            Group {
                Image(systemName: "house.circle")
                    .resizable()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 75, height: 50)
            .clipped()
            .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text("City - Type")
                    .font(.subheadline)
                
                HStack(spacing: 20) {
                    VStack {
                        Text("Price")
                        Text("$$$")
                    }
                    
                    VStack {
                        Text("Bed")
                        Text("0")
                    }
                    
                    VStack {
                        Text("Bath")
                        Text("0")
                    }
                    
                    VStack {
                        Text("SqFt")
                        Text("0")
                    }
                }
                .font(.caption2)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct HomeCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCellView()
    }
}
