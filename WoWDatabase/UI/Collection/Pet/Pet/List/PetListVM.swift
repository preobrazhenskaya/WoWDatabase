//
//  PetListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import Combine

final class PetListVM: BaseViewModel {
	@Published var pets = [NameIdModel]()
	
	private let petApi: PetApiProtocol
	private var listLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(petApi: PetApiProtocol) {
		self.petApi = petApi
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		listLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getPets()
	}
	
	private func getPets() {
		petApi.getPetList()
			.trackLoading(listLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.pets ?? [] }
			.assign(to: \.pets, on: self)
			.store(in: &cancellableSet)
	}
}
