//
//  ToyListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import Combine

final class ToyListVM: BaseViewModel {
	@Published var toys = [NameIdModel]()
	
	private let toyApi: ToyApiProtocol
	private var listLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(toyApi: ToyApiProtocol) {
		self.toyApi = toyApi
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		listLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getToys()
	}
	
	private func getToys() {
		toyApi.getToyList()
			.trackLoading(listLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.toys ?? [] }
			.assign(to: \.toys, on: self)
			.store(in: &cancellableSet)
	}
}
