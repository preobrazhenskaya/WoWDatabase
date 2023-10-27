//
//  AchievementsListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Combine

final class AchievementsListVM: BaseViewModel {
	@Published var achievements = [NameIdModel]()
	
	private let achievementApi: AchievementApiProtocol
	private var listLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(achievementApi: AchievementApiProtocol) {
		self.achievementApi = achievementApi
		super.init()
	}
	
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
		achievementApi.getAchievementsList()
			.trackLoading(listLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.achievements ?? [] }
			.assign(to: \.achievements, on: self)
			.store(in: &cancellableSet)
	}
}
