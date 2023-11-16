//
//  DbService.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 13.11.2023.
//

import CoreData

struct DbService {
	static let shared = DbService(db: PersistenceController.shared)
	
	private let context: NSManagedObjectContext
	
	init(db: PersistenceController) {
		context = db.container.viewContext
	}
}

extension DbService {
	func regUser(login: String, password: String) -> String {
		let newUser = User(context: context)
		newUser.login = login
		newUser.password = password
		newUser.isActive = false
		return context.saveContext()
	}
	
	func authUser(login: String, password: String) -> User? {
		let userPredicate = NSPredicate(format: "login == %@ AND password == %@", login, password)
		let user = try? context.fetch(User.getUsersRequest(predicate: userPredicate)).first
		user?.isActive = true
		let authUser = context.saveContext().isEmpty ? user : nil
		return authUser
	}
	
	func activeUser() -> User? {
		try? context.fetch(User.getUsersRequest(predicate: NSPredicate(format: "isActive == true"))).first
	}
	
	func logout() -> String {
		guard let user = activeUser() else { return L10n.General.error }
		user.isActive = false
		return context.saveContext()
	}
}

extension DbService {
	func checkItemInFav(id: Int, type: Favorites.TypeEnum) -> Bool {
		guard let user = activeUser() else { return false }
		
		let predicate = NSPredicate(format: "id_ == %@ AND type_ == %@", "\(id)", type.rawValue)
		let achievement = try? context.fetch(Favorites.getFavoritesRequest(predicate: predicate)).first
		
		return achievement?.users.contains { $0 == user } ?? false
	}
	
	func addInFavorites(id: Int, name: String?, type: Favorites.TypeEnum) -> String {
		guard let user = activeUser() else { return L10n.General.error }
		
		let predicate = NSPredicate(format: "id_ == %@ AND type_ == %@", "\(id)", type.rawValue)
		let storedFav = try? context.fetch(Favorites.getFavoritesRequest(predicate: predicate)).first
		
		if let storedFav = storedFav {
			storedFav.users.append(user)
		} else {
			let fav = Favorites(context: context)
			fav.id = id
			fav.name = name
			fav.type = type
			fav.users = [user]
		}
		return context.saveContext()
	}
	
	func removeFromFavorites(id: Int, type: Favorites.TypeEnum) -> String {
		guard let user = activeUser() else { return L10n.General.error }
		
		let predicate = NSPredicate(format: "id_ == %@ AND type_ == %@", "\(id)", type.rawValue)
		let fav = try? context.fetch(Favorites.getFavoritesRequest(predicate: predicate)).first
		guard let fav = fav else { return L10n.General.error }
		
		fav.users = fav.users.filter { $0 != user }
		if fav.users.isEmpty {
			context.delete(fav)
		}
		return context.saveContext()
	}
}
