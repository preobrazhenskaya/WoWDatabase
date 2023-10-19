//
//  Router.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import SwiftUI

struct Router {
	enum Destination {
		case achievementDetail(id: Int)
	}
	
	static func navigate(to destination: Destination) -> some View {
		switch destination {
		case let .achievementDetail(id):
			return NavigationLazyView(AchievementDetailView(viewModel: .init(achievementId: id)))
		}
	}
}
