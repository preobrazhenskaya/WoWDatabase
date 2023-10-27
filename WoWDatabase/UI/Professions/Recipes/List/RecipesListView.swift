//
//  RecipesListView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import SwiftUI

struct RecipesListView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: RecipesListVM
	
    var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(viewModel.category.recipes ?? []) { recipe in
					RecipeRowBuilder(recipe: recipe)
				}
			}
			.padding(.all)
		}
		.setNavigationBar(title: viewModel.category.name ?? "", dismiss: dismiss, showBack: true)
		.setViewBaseTheme()
		.withLoader(isLoading: viewModel.isLoading)
		.withErrorAlert(isPresented: $viewModel.showError, errorText: viewModel.errorText.value)
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
		RecipesListView(viewModel:
				.init(category:
						.init(name: "Оружие",
							  recipes: [
								.init(id: 38932,
									  name: "Точно настроенный уничтожатор из штормовой стали"),
								.init(id: 38933,
									  name: "Точно настроенный уничтожатор из штормовой стали"),
								.init(id: 38934,
									  name: "Точно настроенный уничтожатор из штормовой стали")
							  ])
				)
		)
	}
}
