//
//  SkillDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import SwiftUI

struct SkillDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: SkillDetailVM
	
	var body: some View {
		ScrollView { mainView }
			.setNavigationBar(title: viewModel.skill?.name ?? "",
							  dismiss: dismiss,
							  showBack: true)
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
			Color.background
				.cornerRadius(6)
			cardView
		}
		.foregroundColor(.textLight)
		.padding(.all, 16)
	}
	
	var cardView: some View {
		VStack(alignment: .leading) {
			BoldColonRegularTextView(
				boldText: L10n.Skill.Detail.minLevel,
				regularText: viewModel.skill?.minimumSkillLevelString
			)
			BoldColonRegularTextView(
				boldText: L10n.Skill.Detail.maxLevel,
				regularText: viewModel.skill?.maximumSkillLevelString
			)
			recipesList
				.padding(.top, 4)
		}
		.frame(minWidth: 0,
			   maxWidth: .infinity,
			   minHeight: 0,
			   maxHeight: .infinity,
			   alignment: .topLeading)
		.padding(.all, 16)
	}
	
	@ViewBuilder
	var recipesList: some View {
		if !(viewModel.skill?.categories?.isEmpty ?? true) {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Skill.Detail.recipes)
				LazyVStack(alignment: .leading) {
					ForEach(viewModel.skill?.categories ?? []) { category in
						NavigationLink(destination: {
							Router.navigate(to: .recipesList(category: category))
						}, label: {
							NameIdRow(model: .init(id: 1, name: category.name), backgroundColor: .backgroundLight)
						})
					}
				}
			}
		}
	}
}

struct SkillDetailView_Previews: PreviewProvider {
	static var previews: some View {
		SkillDetailView(viewModel: .init(skillId: 2477, professionId: 164, professionApi: MockProfessionApi()))
	}
}
