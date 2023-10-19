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
	@ObservedObject var viewModel: AchievementDetailViewModel
	
	var background: some View {
		Color.backgroundAccent
			.cornerRadius(6)
			.padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
	}
	
	var titleText: some View {
		Text(viewModel.achievement?.name ?? "")
			.bold()
			.font(.largeTitle)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
	}
	
	var mainImage: some View {
		AsyncImage(url: viewModel.achievementIcon) { phase in
			switch phase {
			case .empty:
				CustomProgressView(isLoading: true)
			case let .success(image):
				image
					.resizable()
					.scaledToFill()
					.cornerRadius(10)
					.overlay(
						RoundedRectangle(cornerRadius: 10)
								.stroke(Color.textMain, lineWidth: 2)
					)
			default:
				Image(systemSymbol: .photo)
					.resizable()
					.scaledToFit()
			}
		}
		.frame(width: 200, height: 200)
	}
	
	var descriptionText: some View {
		Text(viewModel.achievement?.description ?? "")
			.padding(.top, 6)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
	}
	
	var categoryText: some View {
		HStack {
			Text("\(L10n.Achievements.Detail.category):")
				.bold()
			Text(viewModel.achievement?.category?.name ?? "")
		}
		.padding(.top, 4)
	}
	
	var factionText: some View {
		HStack {
			Text("\(L10n.Achievements.Detail.faction):")
				.bold()
			Text(viewModel.achievement?.requirements?.faction?.name ?? L10n.Achievements.Detail.factionBoth)
		}
	}
	
	var pointsText: some View {
		HStack {
			Text("\(L10n.Achievements.Detail.points):")
				.bold()
			Text(viewModel.achievement?.pointsString ?? "")
		}
	}
	
	var isAccountWideText: some View {
		HStack {
			Text("\(L10n.Achievements.Detail.isAccountWide):")
				.bold()
			Text(viewModel.achievement?.isAccountWideString ?? "")
		}
	}
	
	var rewardDescriptionText: some View {
		HStack {
			Text("\(L10n.Achievements.Detail.reward):")
				.bold()
			Text(viewModel.achievement?.rewardDescription ?? "-")
		}
	}
	
	func criteriaView(criteria: [AchievementChildCriteriaModel]) -> some View {
		VStack(alignment: .leading) {
			Text("\(L10n.Achievements.Detail.criteria):")
				.bold()
				.padding(.top, 4)
			LazyVStack(alignment: .leading) {
				ForEach(criteria) { criteria in
					if let description = criteria.description {
						Text("• \(description)")
					}
				}
			}
		}
	}
	
	func prevAchievementView(achievement: AchievementShortModel) -> some View {
		VStack(alignment: .leading) {
			Text("\(L10n.Achievements.Detail.prevAchievement):")
				.bold()
				.padding(.top, 4)
			AchievementRowBuilder(achievement: achievement, backgroundColor: .backgroundAccentLight)
		}
	}
	
	func nextAchievementView(achievement: AchievementShortModel) -> some View {
		VStack(alignment: .leading) {
			Text("\(L10n.Achievements.Detail.nextAchievement):")
				.bold()
				.padding(.top, 4)
			AchievementRowBuilder(achievement: achievement, backgroundColor: .backgroundAccentLight)
		}
	}
	
	var body: some View {
		ScrollView {
			ZStack {
				background
				VStack(alignment: .center) {
					titleText
					mainImage
					descriptionText
					VStack(alignment: .leading) {
						categoryText
						factionText
						pointsText
						isAccountWideText
						rewardDescriptionText
						if let criteria = viewModel.achievement?.criteria?.childCriteria {
							criteriaView(criteria: criteria)
						}
						if let prevAchievement = viewModel.achievement?.prerequisiteAchievement {
							prevAchievementView(achievement: prevAchievement)
						}
						if let nextAchievement = viewModel.achievement?.nextAchievement {
							nextAchievementView(achievement: nextAchievement)
						}
					}
					.frame(minWidth: 0,
						   maxWidth: .infinity,
						   minHeight: 0,
						   maxHeight: .infinity,
						   alignment: .topLeading)
				}
				.padding(.init(top: 6, leading: 16, bottom: 16, trailing: 16))
			}
			.foregroundColor(.textMain)
			.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
		}
		.setNavigationBar(title: "", dismiss: dismiss, showBack: true)
		.toolbar(.hidden, for: .tabBar)
		.setBackgroundTheme()
		.withLoader(isLoading: viewModel.isLoading)
		.withErrorAlert(isPresented: $viewModel.showError, errorText: viewModel.errorText.value)
		.onFirstAppear { viewModel.loadData() }
		.refreshable { viewModel.loadData() }
	}
}

struct AchievementDetailView_Previews: PreviewProvider {
	static var previews: some View {
		AchievementDetailView(viewModel: .init(achievementId: 6))
	}
}
