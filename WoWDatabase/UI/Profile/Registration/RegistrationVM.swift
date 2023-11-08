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
	
	func save() {
		let result = AuthService.regUser(login: login, password: password)
		if result.isEmpty {
			showRegMessage = true
		} else {
			errorText.send(result)
		}
	}
}
