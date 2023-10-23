//
//  TabEnum.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 10.10.2023.
//

import SwiftUI
import SFSafeSymbols

enum TabEnum: Int, Identifiable, CaseIterable {
	case professions
	case achievements
	case profile
	
	var id: Int {
	  rawValue
	}
	
	var title: String {
		switch self {
		case .professions:
			return L10n.Tab.professions
		case .achievements:
			return L10n.Tab.achievements
		case .profile:
			return L10n.Tab.profile
		}
	}
	
	var icon: SFSymbol {
		switch self {
		case .professions:
			return SFSymbol.hammerFill
		case .achievements:
			return SFSymbol.starFill
		case .profile:
			return SFSymbol.personFill
		}
	}
	
	@ViewBuilder
	var contentView: some View {
		switch self {
		case .professions:
			ProfessionsListView(viewModel: .init())
		case .achievements:
			AchievementsListView(viewModel: .init())
		case .profile:
			ProfileView(viewModel: .init())
		}
	}
}
