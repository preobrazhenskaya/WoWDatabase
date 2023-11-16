//
//  TitleDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

import Combine

final class TitleDetailVM: BaseViewModel {
	@Published var title: TitleModel?
	@Published var inFav = false
	
	private let titleId: Int
	private let titleApi: TitleApiProtocol
	private let dbService: DbService
	
	private var titleLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(titleId: Int, titleApi: TitleApiProtocol, dbService: DbService) {
		self.titleId = titleId
		self.titleApi = titleApi
		self.dbService = dbService
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		titleLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getTitle()
	}
	
	private func getTitle() {
		titleApi.getTitle(id: titleId)
			.trackLoading(titleLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.title, on: self)
			.store(in: &cancellableSet)
	}
	
	func checkInFav() {
		inFav = dbService.checkItemInFav(id: titleId, type: .title)
	}
	
	func addInFavorites() {
		guard let title = title else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(dbService.addInFavorites(id: titleId, name: title.name, type: .title))
		checkInFav()
	}
	
	func removeFromFavorites() {
		errorText.send(dbService.removeFromFavorites(id: titleId, type: .title))
		checkInFav()
	}
}
