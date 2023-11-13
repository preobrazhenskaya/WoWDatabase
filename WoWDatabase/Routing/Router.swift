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
			NavigationLazyView(AchievementDetailView(viewModel: .init(achievementId: id,
																	  achievementApi: AchievementApi(),
																	  db: PersistenceController.shared)))
		case let .professionDetail(id):
			NavigationLazyView(ProfessionDetailView(viewModel: .init(professionId: id,
																	 professionApi: ProfessionApi(),
																	 db: PersistenceController.shared)))
		case let .skillDetail(skillId, professionId):
			NavigationLazyView(SkillDetailView(viewModel: .init(skillId: skillId,
																professionId: professionId,
																professionApi: ProfessionApi())))
		case let .recipesList(category):
			NavigationLazyView(RecipesListView(viewModel: .init(category: category)))
		case let .recipeDetail(id):
			NavigationLazyView(RecipeDetailView(viewModel: .init(id: id,
																 professionApi: ProfessionApi(),
																 db: PersistenceController.shared)))
		case let .itemDetail(id):
			NavigationLazyView(ItemDetailView(viewModel: .init(id: id,
															   professionApi: ProfessionApi())))
		case .registration:
			NavigationLazyView(RegistrationView(viewModel: .init(db: PersistenceController.shared)))
		case .auth:
			NavigationLazyView(AuthView(viewModel: .init(db: PersistenceController.shared)))
		case .favorites:
			NavigationLazyView(FavoritesView(viewModel: .init(db: PersistenceController.shared)))
		}
	}
}
