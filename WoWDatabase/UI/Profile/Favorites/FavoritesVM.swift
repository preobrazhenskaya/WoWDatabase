//
//  FavoritesVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 08.11.2023.
//

import Combine

final class FavoritesVM: BaseViewModel {
	@Published var favorites = [Favorites]()
	
	private let authService: AuthService
	
	init(db: PersistenceController) {
		authService = AuthService(db: db)
	}
	
	func getFavorites() {
		favorites = authService.getActiveUser()?.favorites.sorted { ($0.name ?? "") < ($1.name ?? "") } ?? []
	}
}
