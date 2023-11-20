//
//  PetDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import Combine
import Foundation

final class PetDetailVM: BaseViewModel {
	@Published var pet: PetModel?
	@Published var petIcon: URL?
	@Published var inFav = false
	
	private let petId: Int
	private let petApi: PetApiProtocol
	private let dbService: DbService
	
	private var petLoading = CurrentValueSubject<Bool, Never>(false)
	var iconLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(petId: Int, petApi: PetApiProtocol, dbService: DbService) {
		self.petId = petId
		self.petApi = petApi
		self.dbService = dbService
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(petLoading, iconLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getPet()
		getPetMedia()
	}
	
	private func getPet() {
		petApi.getPet(id: petId)
			.trackLoading(petLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.pet, on: self)
			.store(in: &cancellableSet)
	}
	
	private func getPetMedia() {
		petApi.getPetMedia(id: petId)
			.trackLoading(iconLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.iconUrl }
			.assign(to: \.petIcon, on: self)
			.store(in: &cancellableSet)
	}
	
	func checkInFav() {
		inFav = dbService.checkItemInFav(id: petId, type: .pet)
	}
	
	func addInFavorites() {
		guard let pet = pet else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(dbService.addInFavorites(id: petId, name: pet.name, type: .pet))
		checkInFav()
	}
	
	func removeFromFavorites() {
		errorText.send(dbService.removeFromFavorites(id: petId, type: .pet))
		checkInFav()
	}
}
