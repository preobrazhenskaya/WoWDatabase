//
//  ProfileVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 19.10.2023.
//

import Combine

final class ProfileVM: BaseViewModel {
	@Published var currentUser: User?
	
	private var tokenLoading = CurrentValueSubject<Bool, Never>(false)
	
	override func bind() {
		super.bind()
		
		tokenLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func updateToken() {
		AuthApi.getToken()
			.trackLoading(tokenLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.accessToken }
			.sink(receiveValue: { AuthService.saveToken($0) })
			.store(in: &cancellableSet)
	}
	
	func getActiveUser() {
		AuthService.getActiveUser()
		currentUser = AuthService.currentUser
	}
	
	func logout() {
		errorText.send(AuthService.logout())
		getActiveUser()
	}
}
