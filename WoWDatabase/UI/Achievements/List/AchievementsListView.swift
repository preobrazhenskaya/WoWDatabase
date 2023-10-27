//
//  AchievementsListView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 29.09.2023.
//

import SwiftUI

struct AchievementsListView: View {
	@ObservedObject var viewModel: AchievementsListVM
	
	var body: some View {
		NavigationStack {
			ScrollView { mainView }
				.setNavigationBar(title: L10n.Tab.achievements, dismiss: nil, showBack: false)
				.setViewBaseTheme()
				.withLoader(isLoading: viewModel.isLoading)
				.withErrorAlert(isPresented: $viewModel.showError,
								errorText: viewModel.errorText.value)
				.onFirstAppear { viewModel.loadData() }
				.refreshable { viewModel.loadData() }
		}
	}
	
	var mainView: some View {
		LazyVStack {
			ForEach(viewModel.achievements) { achievement in
				AchievementRowBuilder(achievement: achievement, backgroundColor: .background)
			}
		}
		.padding(.all)
	}
}

struct AchievementsListView_Previews: PreviewProvider {
	static var previews: some View {
		AchievementsListView(viewModel: .init(achievementApi: MockAchievementApi()))
	}
}
