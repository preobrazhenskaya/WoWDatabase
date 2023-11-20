//
//  AbilityVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import Combine
import Foundation

final class AbilityVM: BaseViewModel {
	@Published var ability: AbilityModel?
	@Published var abilityIcon: URL?
	
	private let abilityId: Int
	private let petApi: PetApiProtocol
	
	private var abilityLoading = CurrentValueSubject<Bool, Never>(false)
	var iconLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(abilityId: Int, petApi: PetApiProtocol) {
		self.abilityId = abilityId
		self.petApi = petApi
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(abilityLoading, iconLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getAbility()
		getAbilityMedia()
	}
	
	private func getAbility() {
		petApi.getPetAbility(id: abilityId)
			.trackLoading(abilityLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.ability, on: self)
			.store(in: &cancellableSet)
	}
	
	private func getAbilityMedia() {
		petApi.getPetAbilityMedia(id: abilityId)
			.trackLoading(iconLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.iconUrl }
			.assign(to: \.abilityIcon, on: self)
			.store(in: &cancellableSet)
	}
}
