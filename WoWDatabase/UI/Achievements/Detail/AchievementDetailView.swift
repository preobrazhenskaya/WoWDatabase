//
//  AchievementDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import SwiftUI
import Combine

struct AchievementDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: AchievementDetailVM
	
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
			CardTitleView(title: viewModel.achievement?.name)
			CardImageView(iconUrl: viewModel.achievementIcon, iconLoading: viewModel.iconLoading.value)
			MultilineText(text: viewModel.achievement?.description ?? "",
						  alignment: .center)
			.padding(.top, 6)
			descriptionView
		}
		.padding(.init(top: 6, leading: 16, bottom: 16, trailing: 16))
	}
	
	var descriptionView: some View {
		VStack(alignment: .leading) {
			BoldColonRegularTextView(
				boldText: L10n.Achievements.Detail.category,
				regularText: viewModel.achievement?.category?.name
			)
			BoldColonRegularTextView(
				boldText: L10n.Achievements.Detail.faction,
				regularText: viewModel.achievement?.requirements?.faction?.name ?? L10n.Achievements.Detail.factionBoth
			)
			BoldColonRegularTextView(
				boldText: L10n.Achievements.Detail.points,
				regularText: viewModel.achievement?.pointsString
			)
			BoldColonRegularTextView(
				boldText: L10n.Achievements.Detail.isAccountWide,
				regularText: viewModel.achievement?.isAccountWideString
			)
			BoldColonRegularTextView(
				boldText: L10n.Achievements.Detail.reward,
				regularText: viewModel.achievement?.rewardDescription
			)
			criteriaView
				.padding(.top, 4)
			prevAchievementView
				.padding(.top, 4)
			nextAchievementView
				.padding(.top, 4)
		}
		.padding(.top, 4)
		.frame(minWidth: 0,
			   maxWidth: .infinity,
			   minHeight: 0,
			   maxHeight: .infinity,
			   alignment: .topLeading)
	}
	
	@ViewBuilder
	var criteriaView: some View {
		if let criteria = viewModel.achievement?.criteria?.childCriteria {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Achievements.Detail.criteria)
				LazyVStack(alignment: .leading) {
					ForEach(criteria) { criteria in
						if let description = criteria.description {
							Text("• \(description)")
						}
					}
				}
			}
		}
	}
	
	@ViewBuilder
	var prevAchievementView: some View {
		if let prevAchievement = viewModel.achievement?.prerequisiteAchievement {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Achievements.Detail.prevAchievement)
				AchievementRowBuilder(achievement: prevAchievement, backgroundColor: .backgroundLight)
			}
		}
	}
	
	@ViewBuilder
	var nextAchievementView: some View {
		if let nextAchievement = viewModel.achievement?.nextAchievement {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Achievements.Detail.nextAchievement)
				AchievementRowBuilder(achievement: nextAchievement, backgroundColor: .backgroundLight)
			}
		}
	}
}

struct AchievementDetailView_Previews: PreviewProvider {
	static var previews: some View {
		AchievementDetailView(viewModel: .init(achievementId: 608, achievementApi: MockAchievementApi()))
	}
}
