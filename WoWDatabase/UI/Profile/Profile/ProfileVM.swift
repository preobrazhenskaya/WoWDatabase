//
//  ProfileVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 19.10.2023.
//

import Combine

final class ProfileVM: BaseViewModel {
	@Published var currentUser: User?
	
	private let authService: AuthService
	private var tokenLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(db: PersistenceController) {
		authService = AuthService(db: db)
	}
	
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
			.sink(receiveValue: { ApiAuthService.saveToken($0) })
			.store(in: &cancellableSet)
	}
	
	func getActiveUser() {
		currentUser = authService.getActiveUser()
	}
	
	func logout() {
		errorText.send(authService.logout())
		getActiveUser()
	}
}
