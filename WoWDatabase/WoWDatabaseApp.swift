//
//  WoWDatabaseApp.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 29.09.2023.
//

import SwiftUI
import Combine

@main
struct WoWDatabaseApp: App {
	var body: some Scene {
		WindowGroup {
			TabsView()
				.preferredColorScheme(.dark)
		}
	}
}
