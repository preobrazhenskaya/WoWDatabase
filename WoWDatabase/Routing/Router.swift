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
		case professionDetail(id: Int)
	}
	
	@ViewBuilder
	static func navigate(to destination: Destination) -> some View {
		switch destination {
		case let .achievementDetail(id):
			NavigationLazyView(AchievementDetailView(viewModel: .init(achievementId: id)))
		case let .professionDetail(id):
			NavigationLazyView(ProfessionDetailView(viewModel: .init(professionId: id)))
		}
	}
}
