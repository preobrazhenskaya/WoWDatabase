//
//  RecipeDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

import Combine
import Foundation

final class RecipeDetailVM: BaseViewModel {
	@Published var recipe: RecipeModel?
	@Published var recipeIcon: URL?
	@Published var inFav = false
	
	private let id: Int
	private let professionApi: ProfessionApiProtocol
	private let dbService: DbService
	
	private var recipeLoading = CurrentValueSubject<Bool, Never>(false)
	var mediaLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(id: Int, professionApi: ProfessionApiProtocol, dbService: DbService) {
		self.id = id
		self.professionApi = professionApi
		self.dbService = dbService
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
		inFav = dbService.checkItemInFav(id: id, type: .recipe)
	}
	
	func addInFavorites() {
		guard let recipe = recipe else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(dbService.addInFavorites(id: id, name: recipe.name, type: .recipe))
		checkInFav()
	}
	
	func removeFromFavorites() {
		errorText.send(dbService.removeFromFavorites(id: id, type: .recipe))
		checkInFav()
	}
}
