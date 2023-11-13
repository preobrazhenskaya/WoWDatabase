//
//  ProfessionDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Combine
import Foundation
import CoreData

final class ProfessionDetailVM: BaseViewModel {
	@Published var profession: ProfessionModel?
	@Published var professionIcon: URL?
	@Published var inFav = false
	
	let professionId: Int
	private let professionApi: ProfessionApiProtocol
	private let dbService: DbService
	
	private var professionLoading = CurrentValueSubject<Bool, Never>(false)
	var mediaLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(professionId: Int, professionApi: ProfessionApiProtocol, dbService: DbService) {
		self.professionId = professionId
		self.professionApi = professionApi
		self.dbService = dbService
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(professionLoading, mediaLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getProfession()
		getMedia()
	}
	
	private func getProfession() {
		professionApi.getProfession(id: professionId)
			.trackLoading(professionLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.profession, on: self)
			.store(in: &cancellableSet)
	}
	
	private func getMedia() {
		professionApi.getProfessionMedia(id: professionId)
			.trackLoading(mediaLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.iconUrl }
			.assign(to: \.professionIcon, on: self)
			.store(in: &cancellableSet)
	}
	
	func checkInFav() {
		inFav = dbService.checkItemInFav(id: professionId, type: .profession)
	}
	
	func addInFavorites() {
		guard let profession = profession else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(dbService.addInFavorites(id: professionId, name: profession.name, type: .profession))
		checkInFav()
	}
	
	func removeFromFavorites() {
		errorText.send(dbService.removeFromFavorites(id: professionId, type: .profession))
		checkInFav()
	}
}
