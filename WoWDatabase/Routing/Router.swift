//
//  Router.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import SwiftUI

struct Router {
	enum Destination {
		case none
		case achievementDetail(id: Int)
		case professionDetail(id: Int)
		case skillDetail(skillId: Int, professionId: Int)
		case recipesList(category: SkillTierCategoriesModel)
		case recipeDetail(id: Int)
		case itemDetail(id: Int)
		case registration
		case auth
		case favorites
	}
	
	@ViewBuilder
	static func navigate(to destination: Destination) -> some View {
		switch destination {
		case .none:
			EmptyView()
		case let .achievementDetail(id):
			NavigationLazyView(AchievementDetailView(viewModel: AchievementDetailVM(achievementId: id, achievementApi: AchievementApi(), dbService: DbService.shared)))
		case let .professionDetail(id):
			NavigationLazyView(ProfessionDetailView(viewModel: ProfessionDetailVM(professionId: id, professionApi: ProfessionApi(), dbService: DbService.shared)))
		case let .skillDetail(skillId, professionId):
			NavigationLazyView(SkillDetailView(viewModel: SkillDetailVM(skillId: skillId, professionId: professionId, professionApi: ProfessionApi())))
		case let .recipesList(category):
			NavigationLazyView(RecipesListView(viewModel: RecipesListVM(category: category)))
		case let .recipeDetail(id):
			NavigationLazyView(RecipeDetailView(viewModel: RecipeDetailVM(id: id, professionApi: ProfessionApi(), dbService: DbService.shared)))
		case let .itemDetail(id):
			NavigationLazyView(ItemDetailView(viewModel: ItemDetailVM(id: id, professionApi: ProfessionApi())))
		case .registration:
			NavigationLazyView(RegistrationView(viewModel: RegistrationVM(dbService: DbService.shared)))
		case .auth:
			NavigationLazyView(AuthView(viewModel: AuthVM(dbService: DbService.shared)))
		case .favorites:
			NavigationLazyView(FavoritesView(viewModel: FavoritesVM(dbService: DbService.shared)))
		}
	}
}
