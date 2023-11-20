//
//  RecipeDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

import SwiftUI

struct RecipeDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: RecipeDetailVM
	
	var body: some View {
		ScrollView {
			DetailCardMainView(title: viewModel.recipe?.name,
							   icon: viewModel.recipeIcon,
							   iconLoading: viewModel.mediaLoading.value,
							   description: viewModel.recipe?.description,
							   descriptionView: descriptionView,
							   withFav: true,
							   inFav: viewModel.inFav,
							   removeFromFavorites: { viewModel.removeFromFavorites() },
							   addInFavorites: { viewModel.addInFavorites() })
		}
		.setNavigationBar(title: "", dismiss: dismiss, showBack: true)
		.toolbarBackground(.hidden, for: .navigationBar)
		.toolbar(.hidden, for: .tabBar)
		.setViewBaseTheme()
		.withLoader(isLoading: viewModel.isLoading)
		.withErrorAlert(isPresented: $viewModel.showError,
						errorText: viewModel.errorText.value)
		.onFirstAppear { viewModel.loadData() }
		.refreshable { viewModel.loadData() }
		.onAppear { viewModel.checkInFav() }
	}
	
	var descriptionView: some View {
		VStack(alignment: .leading) {
			BoldColonRegularTextView(boldText: L10n.Recipe.Detail.rank,
									 regularText: viewModel.recipe?.rankString)
			itemView
			reagentsView
				.padding(.top, 4)
		}
	}
	
	var itemView: some View {
		VStack(alignment: .leading) {
			if let item = viewModel.recipe?.craftedItem {
				ItemRowBuilder(item: .init(id: item.id, name: "\(item.name ?? "") (\(viewModel.recipe?.craftedQuantity?.value ?? 0))"))
			}
			if let item = viewModel.recipe?.allianceCraftedItem {
				ItemRowBuilder(item: .init(id: item.id, name: "\(item.name ?? "") (\(viewModel.recipe?.craftedQuantity?.value ?? 0)) (\(L10n.General.alliance))"))
			}
			if let item = viewModel.recipe?.hordeCraftedItem {
				ItemRowBuilder(item: .init(id: item.id, name: "\(item.name ?? "") (\(viewModel.recipe?.craftedQuantity?.value ?? 0)) (\(L10n.General.horde))"))
			}
		}
	}
	
	@ViewBuilder
	var reagentsView: some View {
		if let reagents = viewModel.recipe?.reagents {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Recipe.Detail.reagents)
				LazyVStack(alignment: .leading) {
					ForEach(reagents) { reagent in
						if let reagentModel = reagent.reagent {
						ItemRowBuilder(item: .init(id: reagentModel.id, name: "\(reagentModel.name ?? "") (\(reagent.quantity ?? 0))"))
						}
					}
				}
			}
		}
	}
}

struct RecipeDetailView_Previews: PreviewProvider {
	static var previews: some View {
		let db = PreviewService.createDbWithUser()
		let vm = RecipeDetailVM(id: 42347,
								professionApi: MockProfessionApi(),
								dbService: DbService(db: db))
		return RecipeDetailView(viewModel: vm)
	}
}
