//
//  RecipesListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Combine

final class RecipesListVM: BaseViewModel {
	let category: SkillTierCategoriesModel
	
	init(category: SkillTierCategoriesModel) {
		self.category = category
		super.init()
	}
}
