//
//  TitleListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

import Combine

final class TitleListVM: BaseViewModel {
	@Published var titles = [NameIdModel]()
	
	private let titleApi: TitleApiProtocol
	private var listLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(titleApi: TitleApiProtocol) {
		self.titleApi = titleApi
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		listLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getTitles()
	}
	
	private func getTitles() {
		titleApi.getTitleList()
			.trackLoading(listLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.titles ?? [] }
			.assign(to: \.titles, on: self)
			.store(in: &cancellableSet)
	}
}
