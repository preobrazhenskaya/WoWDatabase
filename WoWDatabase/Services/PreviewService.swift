//
//  PreviewService.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 09.11.2023.
//

struct PreviewService {
	static func createDbWithUser() -> PersistenceController {
		let db = PersistenceController(inMemory: true)
		let viewContext = db.container.viewContext
		
		let user = User(context: viewContext)
		user.login = "Preview"
		user.password = "1234"
		user.isActive = true
		_ = viewContext.saveContext()
		
		return db
	}
	
	static func createDbWithFavorites() -> PersistenceController {
		let db = PersistenceController(inMemory: true)
		let viewContext = db.container.viewContext
		
		let fav = Favorites(context: viewContext)
		fav.id = 1
		fav.name = "Preview fav 1"
		fav.type = .achievement
		
		let user = User(context: viewContext)
		user.login = "Preview"
		user.password = "1234"
		user.isActive = true
		user.favorites = [fav]
		_ = viewContext.saveContext()
		
		return db
	}
}
