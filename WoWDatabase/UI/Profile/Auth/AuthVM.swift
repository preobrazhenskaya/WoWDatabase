//
//  AuthVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 01.11.2023.
//

import Combine

final class AuthVM: BaseViewModel {
	@Published var login = ""
	@Published var password = ""
	@Published var showAuthMessage = false
	
	private let authService: AuthService
	
	init(db: PersistenceController) {
		authService = AuthService(db: db)
	}
	
	func auth() {
		let user = authService.authUser(login: login, password: password)
		if user == nil {
			errorText.send(L10n.Auth.error)
		} else {
			showAuthMessage = true
		}
	}
}
