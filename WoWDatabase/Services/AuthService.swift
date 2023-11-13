//
//  AuthService.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 09.11.2023.
//

import CoreData

struct AuthService {
	private let context: NSManagedObjectContext
	
	init(db: PersistenceController) {
		context = db.container.viewContext
	}
	
	func regUser(login: String, password: String) -> String {
		let newUser = User(context: context)
		newUser.login = login
		newUser.password = password
		newUser.isActive = false
		return context.saveContext()
	}
	
	func authUser(login: String, password: String) -> User? {
		let userPredicate = NSPredicate(format: "login == %@ AND password == %@", login, password)
		let user = try? context.fetch(User.findUserRequest(predicate: userPredicate)).first
		user?.isActive = true
		let authUser = context.saveContext().isEmpty ? user : nil
		return authUser
	}
	
	func getActiveUser() -> User? {
		let userPredicate = NSPredicate(format: "isActive == true")
		return try? context.fetch(User.findUserRequest(predicate: userPredicate)).first
	}
	
	func logout() -> String {
		getActiveUser()?.isActive = false
		return context.saveContext()
	}
}
