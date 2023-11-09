//
//  AuthService.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 19.10.2023.
//

import Foundation

struct AuthService {
	static private let viewContext = PersistenceController.shared.container.viewContext
	static var currentUser: User?
	
	static func getClientId() -> String {
		Bundle.main.object(forInfoDictionaryKey: Constants.Services.Auth.clientId) as? String ?? ""
	}
	
	static func getClientSecret() -> String {
		Bundle.main.object(forInfoDictionaryKey: Constants.Services.Auth.clientSecret) as? String ?? ""
	}
	
	static func saveToken(_ token: String?) {
		UserDefaults.standard.setValue(token, forKey: Constants.Services.Auth.token)
	}
	
	static func getToken() -> String? {
		UserDefaults.standard.string(forKey: Constants.Services.Auth.token)
	}
	
	static func regUser(login: String, password: String) -> String {
		let newUser = User(context: viewContext)
		newUser.login = login
		newUser.password = password
		newUser.isActive = false
		return viewContext.saveContext()
	}
	
	static func authUser(login: String, password: String) -> User? {
		let userPredicate = NSPredicate(format: "login == %@ AND password == %@", login, password)
		let user = try? viewContext.fetch(User.findUserRequest(predicate: userPredicate)).first
		user?.isActive = true
		let authUser = viewContext.saveContext().isEmpty ? user : nil
		return authUser
	}
	
	static func getActiveUser() {
		let userPredicate = NSPredicate(format: "isActive == true")
		currentUser = try? viewContext.fetch(User.findUserRequest(predicate: userPredicate)).first
	}
	
	static func logout() -> String {
		currentUser?.isActive = false
		return viewContext.saveContext()
	}
}
