//
//  AchievementDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Combine
import Foundation

final class AchievementDetailVM: BaseViewModel {
	@Published var achievement: AchievementModel?
	@Published var achievementIcon: URL?
	
	private let achievementId: Int
	private let achievementApi: AchievementApiProtocol
	private var achievementLoading = CurrentValueSubject<Bool, Never>(false)
	var iconLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(achievementId: Int, achievementApi: AchievementApiProtocol) {
		self.achievementId = achievementId
		self.achievementApi = achievementApi
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(achievementLoading, iconLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getAchievement()
		getAchievementMedia()
	}
	
	private func getAchievement() {
		achievementApi.getAchievement(id: achievementId)
			.trackLoading(achievementLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.achievement, on: self)
			.store(in: &cancellableSet)
	}
	
	private func getAchievementMedia() {
		achievementApi.getAchievementMedia(id: achievementId)
			.trackLoading(iconLoading)
			.getError(errorText)
			.getResult()
			.map { URL(string: $0?.assets?.first?.value ?? "") }
			.assign(to: \.achievementIcon, on: self)
			.store(in: &cancellableSet)
	}
}
