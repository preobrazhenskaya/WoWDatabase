//
//  RecipeDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

import Combine
import Foundation
import CoreData

final class RecipeDetailVM: BaseViewModel {
	@Published var recipe: RecipeModel?
	@Published var recipeIcon: URL?
	@Published var inFav = false
	
	private let id: Int
	private let professionApi: ProfessionApiProtocol
	private let context: NSManagedObjectContext
	private let authService: AuthService
	
	private lazy var user = authService.getActiveUser()
	private var recipeLoading = CurrentValueSubject<Bool, Never>(false)
	var mediaLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(id: Int, professionApi: ProfessionApiProtocol, db: PersistenceController) {
		self.id = id
		self.professionApi = professionApi
		context = db.container.viewContext
		authService = AuthService(db: db)
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(recipeLoading, mediaLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getRecipe()
		getMedia()
	}
	
	private func getRecipe() {
		professionApi.getRecipe(id: id)
			.trackLoading(recipeLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.recipe, on: self)
			.store(in: &cancellableSet)
	}
	
	private func getMedia() {
		professionApi.getRecipeMedia(id: id)
			.trackLoading(recipeLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.iconUrl }
			.assign(to: \.recipeIcon, on: self)
			.store(in: &cancellableSet)
	}
	
	func checkInFav() {
		guard let user = user else { return }
		inFav = Favorites.checkInFav(id: id, type: .recipe, user: user, context: context)
	}
	
	func addInFavorites() {
		guard let recipe = recipe, let user = user else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(Favorites.saveFav(id: id, name: recipe.name, type: .recipe, user: user, context: context))
		checkInFav()
	}
	
	func removeFromFavorites() {
		guard let user = user else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(Favorites.removeFav(id: id, type: .recipe, user: user, context: context))
		checkInFav()
	}
}
