//
//  AchievementsListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Combine

final class AchievementsListVM: BaseViewModel {
	@Published var achievements = [NameIdModel]()
	
	private var listLoading = PassthroughSubject<Bool, Never>()
	
	override func bind() {
		super.bind()
		
		listLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getAchievements()
	}
	
	private func getAchievements() {
//		achievements = [
//			.init(id: 6, name: "10-й уровень"),
//			.init(id: 7, name: "20-й уровень")
//		]
		AchievementApi.getAchievementsList()
			.trackLoading(listLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.achievements ?? [] }
			.assign(to: \.achievements, on: self)
			.store(in: &cancellableSet)
	}
}
