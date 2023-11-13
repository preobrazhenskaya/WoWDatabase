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
	private let authService: AuthService
	
	private lazy var user = authService.getActiveUser()
	private var achievementLoading = CurrentValueSubject<Bool, Never>(false)
	var iconLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(achievementId: Int, achievementApi: AchievementApiProtocol, db: PersistenceController) {
		self.achievementId = achievementId
		self.achievementApi = achievementApi
		context = db.container.viewContext
		authService = AuthService(db: db)
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
		guard let user = user else { return }
		inFav = Favorites.checkInFav(id: achievementId, type: .achievement, user: user, context: context)
	}
	
	func addInFavorites() {
		guard let achievement = achievement, let user = user else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(Favorites.saveFav(achievement: achievement, user: user, context: context))
		checkInFav()
	}
	
	func removeFromFavorites() {
		guard let user = user else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(Favorites.removeFav(id: achievementId, type: .achievement, user: user, context: context))
		checkInFav()
	}
}
