//
//  ProfessionDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Combine
import Foundation
import CoreData

final class ProfessionDetailVM: BaseViewModel {
	@Published var profession: ProfessionModel?
	@Published var professionIcon: URL?
	@Published var inFav = false
	
	let professionId: Int
	private let professionApi: ProfessionApiProtocol
	private let context: NSManagedObjectContext
	private let authService: AuthService
	
	private lazy var user = authService.getActiveUser()
	private var professionLoading = CurrentValueSubject<Bool, Never>(false)
	var mediaLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(professionId: Int, professionApi: ProfessionApiProtocol, db: PersistenceController) {
		self.professionId = professionId
		self.professionApi = professionApi
		context = db.container.viewContext
		authService = AuthService(db: db)
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(professionLoading, mediaLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getProfession()
		getMedia()
	}
	
	private func getProfession() {
		professionApi.getProfession(id: professionId)
			.trackLoading(professionLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.profession, on: self)
			.store(in: &cancellableSet)
	}
	
	private func getMedia() {
		professionApi.getProfessionMedia(id: professionId)
			.trackLoading(mediaLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.iconUrl }
			.assign(to: \.professionIcon, on: self)
			.store(in: &cancellableSet)
	}
	
	func checkInFav() {
		guard let user = user else { return }
		inFav = Favorites.checkInFav(id: professionId, type: .profession, user: user, context: context)
	}
	
	func addInFavorites() {
		guard let profession = profession, let user = user else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(Favorites.saveFav(id: professionId, name: profession.name, type: .profession, user: user, context: context))
		checkInFav()
	}
	
	func removeFromFavorites() {
		guard let user = user else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(Favorites.removeFav(id: professionId, type: .profession, user: user, context: context))
		checkInFav()
	}
}
