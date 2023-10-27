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
	
	private let id: Int
	private let professionApi: ProfessionApiProtocol
	private var recipeLoading = CurrentValueSubject<Bool, Never>(false)
	var mediaLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(id: Int, professionApi: ProfessionApiProtocol) {
		self.id = id
		self.professionApi = professionApi
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
}
