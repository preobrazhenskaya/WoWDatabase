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
		case professionDetail(id: Int)
		case skillDetail(skillId: Int, professionId: Int)
		case recipesList(category: SkillTierCategoriesModel)
		case recipeDetail(id: Int)
		case itemDetail(id: Int)
		case achievementsList
		case achievementDetail(id: Int)
		case titleList
		case titleDetail(id: Int)
		case mountList
		case mountDetail(id: Int)
		case petList
		case petDetail(id: Int)
		case abilityDetail(id: Int)
		case toyList
		case toyDetail(id: Int)
		case registration
		case auth
		case favorites
	}
	
	@ViewBuilder
	static func navigate(to destination: Destination) -> some View {
		switch destination {
		case .none:
			EmptyView()
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
		case .achievementsList:
			NavigationLazyView(AchievementsListView(viewModel: AchievementsListVM(achievementApi: AchievementApi())))
		case let .achievementDetail(id):
			NavigationLazyView(AchievementDetailView(viewModel: AchievementDetailVM(achievementId: id, achievementApi: AchievementApi(), dbService: DbService.shared)))
		case .titleList:
			NavigationLazyView(TitleListView(viewModel: TitleListVM(titleApi: TitleApi())))
		case let .titleDetail(id):
			NavigationLazyView(TitleDetailView(viewModel: TitleDetailVM(titleId: id, titleApi: TitleApi(), dbService: DbService.shared)))
		case .mountList:
			NavigationLazyView(MountListView(viewModel: MountListVM(mountApi: MountApi())))
		case let .mountDetail(id):
			NavigationLazyView(MountDetailView(viewModel: MountDetailVM(mountId: id, mountApi: MountApi(), dbService: DbService.shared)))
		case .petList:
			NavigationLazyView(PetListView(viewModel: PetListVM(petApi: PetApi())))
		case let .petDetail(id):
			NavigationLazyView(PetDetailView(viewModel: PetDetailVM(petId: id, petApi: PetApi(), dbService: DbService.shared)))
		case let .abilityDetail(id):
			NavigationLazyView(AbilityView(viewModel: AbilityVM(abilityId: id, petApi: PetApi())))
		case .toyList:
			NavigationLazyView(ToyListView(viewModel: ToyListVM(toyApi: ToyApi())))
		case let .toyDetail(id):
			NavigationLazyView(ToyDetailView(viewModel: ToyDetailVM(toyId: id, toyApi: ToyApi(), dbService: DbService.shared)))
		case .registration:
			NavigationLazyView(RegistrationView(viewModel: RegistrationVM(dbService: DbService.shared)))
		case .auth:
			NavigationLazyView(AuthView(viewModel: AuthVM(dbService: DbService.shared)))
		case .favorites:
			NavigationLazyView(FavoritesView(viewModel: FavoritesVM(dbService: DbService.shared)))
		}
	}
}
