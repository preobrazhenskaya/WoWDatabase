//
//  TitleDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

import SwiftUI

struct TitleDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: TitleDetailVM
	
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
			.onAppear { viewModel.checkInFav() }
	}
	
	var mainView: some View {
		VStack {
			MultilineText(text: viewModel.title?.name ?? "", alignment: .center)
				.font(.customBoldLargeTitle)
			ZStack {
				ZStack(alignment: .top) {
					Color.background
						.cornerRadius(6)
					HStack {
						Spacer()
						FavoriteImage(inFav: viewModel.inFav,
									  removeFromFavorites: { viewModel.removeFromFavorites() },
									  addInFavorites: { viewModel.addInFavorites() })
					}
					.padding([.top, .trailing], 16)
				}
				descriptionView
					.padding(.all, 16)
					.frame(minWidth: 0,
						   maxWidth: .infinity,
						   minHeight: 0,
						   maxHeight: .infinity,
						   alignment: .topLeading)
			}
		}
		.foregroundColor(.textLight)
		.padding([.leading, .trailing], 16)
	}
	
	var descriptionView: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .leading) {
				BoldColonRegularTextView(boldText: L10n.Title.Detail.female,
										 regularText: viewModel.title?.genderName?.female)
				BoldColonRegularTextView(boldText: L10n.Title.Detail.male,
										 regularText: viewModel.title?.genderName?.male)
			}
			.padding(.trailing, 48)
			sourceView
				.padding(.top, 4)
		}
	}
	
	@ViewBuilder
	var sourceView: some View {
		if let achievement = viewModel.title?.source?.achievements?.first {
			BoldColonTextView(boldText: L10n.Title.Detail.source)
			AchievementRowBuilder(achievement: achievement,
								  backgroundColor: .backgroundLight)
		}
	}
}

struct TitleDetailView_Previews: PreviewProvider {
	static var previews: some View {
		let db = PreviewService.createDbWithUser()
		let vm = TitleDetailVM(titleId: 122,
							   titleApi: MockTitleApi(),
							   dbService: DbService(db: db))
		return TitleDetailView(viewModel: vm)
	}
}
