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
	@Published var inFav = false
	
	private let achievementId: Int
	private let achievementApi: AchievementApiProtocol
	private let dbService: DbService
	
	private var achievementLoading = CurrentValueSubject<Bool, Never>(false)
	var iconLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(achievementId: Int, achievementApi: AchievementApiProtocol, dbService: DbService) {
		self.achievementId = achievementId
		self.achievementApi = achievementApi
		self.dbService = dbService
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
			.map { $0?.iconUrl }
			.assign(to: \.achievementIcon, on: self)
			.store(in: &cancellableSet)
	}
	
	func checkInFav() {
		inFav = dbService.checkItemInFav(id: achievementId, type: .achievement)
	}
	
	func addInFavorites() {
		guard let achievement = achievement else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(dbService.addInFavorites(id: achievementId, name: achievement.name, type: .achievement))
		checkInFav()
	}
	
	func removeFromFavorites() {
		errorText.send(dbService.removeFromFavorites(id: achievementId, type: .achievement))
		checkInFav()
	}
}
