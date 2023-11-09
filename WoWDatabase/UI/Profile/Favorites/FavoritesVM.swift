//
//  FavoritesVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 08.11.2023.
//

import Combine

final class FavoritesVM: BaseViewModel {
	@Published var favorites = [Favorites]()
	
	func getFavorites() {
		favorites = AuthService.currentUser?.favorites ?? []
	}
}
