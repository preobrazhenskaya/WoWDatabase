//
//  AchievementDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Combine
import Foundation
import CoreData

final class AchievementDetailVM: BaseViewModel {
	@Published var achievement: AchievementModel?
	@Published var achievementIcon: URL?
	@Published var inFav = false
	
	private let achievementId: Int
	private let achievementApi: AchievementApiProtocol
	private let context: NSManagedObjectContext
	private var achievementLoading = CurrentValueSubject<Bool, Never>(false)
	var iconLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(achievementId: Int, achievementApi: AchievementApiProtocol, db: PersistenceController) {
		self.achievementId = achievementId
		self.achievementApi = achievementApi
		self.context = db.container.viewContext
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
		inFav = Favorites.checkInFav(id: achievementId, type: .achievement, context: context)
	}
	
	func addInFavorites() {
		guard let achievement = achievement else { return }
		errorText.send(Favorites.saveFav(achievement: achievement, context: context))
		checkInFav()
	}
	
	func removeFromFavorites() {
		errorText.send(Favorites.removeFav(id: achievementId, type: .achievement, context: context))
		checkInFav()
	}
}
