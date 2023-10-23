//
//  ProfessionsListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Combine

final class ProfessionsListVM: BaseViewModel {
	@Published var professions = [NameIdModel]()
	
	private var professionsLoading = CurrentValueSubject<Bool, Never>(false)
	
	override func bind() {
		super.bind()
		
		professionsLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getProfessions()
	}
	
	private func getProfessions() {
		ProfessionApi.getProfessionsList()
			.trackLoading(professionsLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.professions ?? [] }
			.assign(to: \.professions, on: self)
			.store(in: &cancellableSet)
	}
}
