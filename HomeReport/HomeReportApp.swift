//
//  HomeReportApp.swift
//  HomeReport
//
//  Created by Felipe Israel on 29/09/21.
//

import SwiftUI

@main
struct HomeReportApp: App {
    let homeManager = HomeManager(
        context: PersistenceManager().container.viewContext
    )
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(homeManager)
        }
    }
}
