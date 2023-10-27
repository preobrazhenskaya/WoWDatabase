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
	
	var background: some View {
		Color.background
			.cornerRadius(6)
	}
	
	var minLevelText: some View {
		HStack {
			Text("\(L10n.Skill.Detail.minLevel):")
				.bold()
			Text(viewModel.skill?.minimumSkillLevelString ?? "")
		}
	}
	
	var maxLevelText: some View {
		HStack {
			Text("\(L10n.Skill.Detail.maxLevel):")
				.bold()
			Text(viewModel.skill?.maximumSkillLevelString ?? "")
		}
	}
	
	var recipesList: some View {
		VStack(alignment: .leading) {
			Text("\(L10n.Skill.Detail.recipes):")
				.bold()
				.padding(.top, 4)
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
	
    var body: some View {
		ScrollView {
			ZStack {
				background
				VStack(alignment: .leading) {
					minLevelText
					maxLevelText
					if !(viewModel.skill?.categories?.isEmpty ?? true) {
						recipesList
					}
				}
				.frame(minWidth: 0,
					   maxWidth: .infinity,
					   minHeight: 0,
					   maxHeight: .infinity,
					   alignment: .topLeading)
				.padding(.all, 16)
			}
			.foregroundColor(.textMain)
			.padding(.all, 16)
		}
		.setNavigationBar(title: viewModel.skill?.name ?? "", dismiss: dismiss, showBack: true)
		.toolbar(.hidden, for: .tabBar)
		.setViewBaseTheme()
		.withLoader(isLoading: viewModel.isLoading)
		.withErrorAlert(isPresented: $viewModel.showError, errorText: viewModel.errorText.value)
		.onFirstAppear { viewModel.loadData() }
		.refreshable { viewModel.loadData() }
    }
}

struct SkillDetailView_Previews: PreviewProvider {
    static var previews: some View {
		SkillDetailView(viewModel: .init(skillId: 2477, professionId: 164, professionApi: MockProfessionApi()))
    }
}
