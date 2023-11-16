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
	case collection
	case profile
	
	var id: Int {
	  rawValue
	}
	
	var title: String {
		switch self {
		case .professions:
			return L10n.Professions.title
		case .collection:
			return L10n.Collection.title
		case .profile:
			return L10n.Profile.title
		}
	}
	
	var icon: SFSymbol {
		switch self {
		case .professions:
			return SFSymbol.hammerFill
		case .collection:
			return SFSymbol.booksVerticalFill
		case .profile:
			return SFSymbol.personFill
		}
	}
	
	@ViewBuilder
	var contentView: some View {
		switch self {
		case .professions:
			ProfessionsListView(viewModel: ProfessionsListVM(professionApi: ProfessionApi()))
		case .collection:
			CollectionView(viewModel: CollectionVM())
		case .profile:
			ProfileView(viewModel: ProfileVM(dbService: DbService.shared))
		}
	}
}
