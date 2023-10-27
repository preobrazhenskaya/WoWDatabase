//
//  ProfessionsListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Combine

final class ProfessionsListVM: BaseViewModel {
	@Published var professions = [NameIdModel]()
	
	private let professionApi: ProfessionApiProtocol
	private var professionsLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(professionApi: ProfessionApiProtocol) {
		self.professionApi = professionApi
		super.init()
	}
	
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
		professionApi.getProfessionsList()
			.trackLoading(professionsLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.professions ?? [] }
			.assign(to: \.professions, on: self)
			.store(in: &cancellableSet)
	}
}
