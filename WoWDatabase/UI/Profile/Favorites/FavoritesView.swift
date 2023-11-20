//
//  FavoritesView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 08.11.2023.
//

import SwiftUI

struct FavoritesView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: FavoritesVM
	
	var body: some View {
		ZStack {
			if viewModel.favorites.isEmpty {
				EmptySearchView()
					.foregroundColor(.white)
					.frame(minWidth: 0,
						   maxWidth: .infinity,
						   minHeight: 0,
						   maxHeight: .infinity,
						   alignment: .center)
			} else {
				listView
			}
		}
		.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
		.setNavigationBar(title: L10n.Fav.title, dismiss: dismiss, showBack: true)
		.toolbar(.hidden, for: .tabBar)
		.setViewBaseTheme()
		.withLoader(isLoading: viewModel.isLoading)
		.withErrorAlert(isPresented: $viewModel.showError,
						errorText: viewModel.errorText.value)
		.onAppear { viewModel.getFavorites() }
	}
	
	var listView: some View {
		ScrollView {
			LazyVStack {
				ForEach(viewModel.favorites) { favorites in
					NavigationLink(destination: {
						switch favorites.type {
						case .achievement:
							Router.navigate(to: .achievementDetail(id: favorites.id))
						case .profession:
							Router.navigate(to: .professionDetail(id: favorites.id))
						case .recipe:
							Router.navigate(to: .recipeDetail(id: favorites.id))
						case .title:
							Router.navigate(to: .titleDetail(id: favorites.id))
						case .mount:
							Router.navigate(to: .mountDetail(id: favorites.id))
						case .pet:
							Router.navigate(to: .petDetail(id: favorites.id))
						case .toy:
							Router.navigate(to: .toyDetail(id: favorites.id))
						case .none:
							Router.navigate(to: .none)
						}
					}, label: {
						NameIdRow(model: .init(id: favorites.id, name: favorites.name), backgroundColor: .background)
					})
				}
			}
		}
	}
}

struct FavoritesView_Previews: PreviewProvider {
	static var previews: some View {
		let db = PreviewService.createDbWithFavorites()
		let vm = FavoritesVM(dbService: DbService(db: db))
		return FavoritesView(viewModel: vm)
	}
}
