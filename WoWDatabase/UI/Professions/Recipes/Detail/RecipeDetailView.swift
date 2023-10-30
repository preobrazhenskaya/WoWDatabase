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
		ScrollView { mainView }
			.setNavigationBar(title: "", dismiss: dismiss, showBack: true)
			.toolbarBackground(.hidden, for: .navigationBar)
			.toolbar(.hidden, for: .tabBar)
			.setViewBaseTheme()
			.withLoader(isLoading: viewModel.isLoading)
			.withErrorAlert(isPresented: $viewModel.showError,
							errorText: viewModel.errorText.value)
			.onFirstAppear { viewModel.loadData() }
			.refreshable { viewModel.loadData() }
	}
	
	var mainView: some View {
		ZStack {
			CardBackgroundView()
				.padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
			cardView
		}
		.foregroundColor(.textMain)
		.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
	}
	
	var cardView: some View {
		VStack(alignment: .center) {
			CardTitleView(title: viewModel.recipe?.name)
			CardImageView(iconUrl: viewModel.recipeIcon,
						  iconLoading: viewModel.mediaLoading.value)
			MultilineText(text: viewModel.recipe?.description ?? "",
						  alignment: .center)
			.padding(.top, 6)
			descriptionView
		}
		.padding(.init(top: 6, leading: 16, bottom: 16, trailing: 16))
	}
	
	var descriptionView: some View {
		VStack(alignment: .leading) {
			BoldColonRegularTextView(boldText: L10n.Recipe.Detail.rank,
									 regularText: viewModel.recipe?.rankString)
			.padding(.top, 4)
			itemView
			reagentsView
				.padding(.top, 4)
		}
		.frame(minWidth: 0,
			   maxWidth: .infinity,
			   minHeight: 0,
			   maxHeight: .infinity,
			   alignment: .topLeading)
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
		RecipeDetailView(viewModel: .init(id: 42347, professionApi: MockProfessionApi()))
	}
}
