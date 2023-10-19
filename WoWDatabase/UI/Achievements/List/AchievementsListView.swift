//
//  AchievementsListView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 29.09.2023.
//

import SwiftUI

struct AchievementsListView: View {
	@ObservedObject var viewModel: AchievementsListViewModel
	
	var body: some View {
		NavigationStack {
			ScrollView {
				LazyVStack {
					ForEach(viewModel.achievements) { achievement in
						AchievementRowBuilder(achievement: achievement, backgroundColor: .backgroundAccent)
					}
				}
				.padding(.all)
			}
			.setNavigationBar(title: L10n.Tab.achievements, dismiss: nil, showBack: false)
			.setBackgroundTheme()
			.withLoader(isLoading: viewModel.isLoading)
			.withErrorAlert(isPresented: $viewModel.showError, errorText: viewModel.errorText.value)
			.onFirstAppear { viewModel.loadData() }
			.refreshable { viewModel.loadData() }
		}
	}
}

struct AchievementsListView_Previews: PreviewProvider {
	static var previews: some View {
		AchievementsListView(viewModel: AchievementsListViewModel())
	}
}
