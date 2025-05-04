//
//  Weather_SwiftUIApp.swift
//  Weather_SwiftUI
//
//  Created by name on 27/04/2025.
//

import SwiftUI

@main
struct Weather_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear {
                    Task {
                      let weather =  try await WeatherRequest().perform()
                        print("❌",weather)
                    }
                }
        }
    }
}
