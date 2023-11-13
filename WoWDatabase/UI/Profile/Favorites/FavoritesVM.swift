//
//  FavoritesVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 08.11.2023.
//

import Combine

final class FavoritesVM: BaseViewModel {
	@Published var favorites = [Favorites]()
	
	private let dbService: DbService
	
	init(dbService: DbService) {
		self.dbService = dbService
	}
	
	func getFavorites() {
		favorites = dbService.user?.favorites.sorted { ($0.name ?? "") < ($1.name ?? "") } ?? []
	}
}
