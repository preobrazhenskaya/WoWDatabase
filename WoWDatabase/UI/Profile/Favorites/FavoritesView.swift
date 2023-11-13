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
			ForEach(viewModel.favorites) { favorites in
				NavigationLink(destination: {
					switch favorites.type {
					case .achievement:
						Router.navigate(to: .achievementDetail(id: favorites.id))
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

struct FavoritesView_Previews: PreviewProvider {
	static var previews: some View {
		FavoritesView(viewModel: .init(db: PreviewService.createDbWithFavorites()))
	}
}
