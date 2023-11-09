//
//  RegistrationVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 31.10.2023.
//

import Combine

final class RegistrationVM: BaseViewModel {
	@Published var login = ""
	@Published var password = ""
	@Published var showRegMessage = false
	
	private let authService: AuthService
	
	init(db: PersistenceController) {
		authService = AuthService(db: db)
	}
	
	func save() {
		let result = authService.regUser(login: login, password: password)
		if result.isEmpty {
			showRegMessage = true
		} else {
			errorText.send(result)
		}
	}
}
