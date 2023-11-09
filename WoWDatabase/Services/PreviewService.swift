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
}
