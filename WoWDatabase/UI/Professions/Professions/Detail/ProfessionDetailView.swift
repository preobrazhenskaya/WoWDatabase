//
//  ProfessionDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import SwiftUI

struct ProfessionDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: ProfessionDetailVM
	
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
			CardTitleView(title: viewModel.profession?.name)
			CardImageView(iconUrl: viewModel.professionIcon, iconLoading: viewModel.mediaLoading.value)
			descriptionText
			descriptionView
		}
		.padding(.init(top: 6, leading: 16, bottom: 16, trailing: 16))
	}
	
	var descriptionText: some View {
		Text(viewModel.profession?.description ?? "")
			.padding(.top, 6)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
	}
	
	var descriptionView: some View {
		VStack(alignment: .leading) {
			BoldColonRegularTextView(
				boldText: L10n.Professions.Detail.type,
				regularText: viewModel.profession?.type?.name
			)
			.padding(.top, 4)
			skillList
				.padding(.top, 4)
		}
		.frame(minWidth: 0,
			   maxWidth: .infinity,
			   minHeight: 0,
			   maxHeight: .infinity,
			   alignment: .topLeading)
	}
	
	@ViewBuilder
	var skillList: some View {
		if !(viewModel.profession?.skillTiers?.isEmpty ?? true) {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Professions.Detail.skills)
				LazyVStack(alignment: .leading) {
					ForEach(viewModel.profession?.skillTiers ?? []) { skill in
						SkillRowBuilder(skill: skill, professionId: viewModel.professionId)
					}
				}
			}
		}
	}
}

struct ProfessionDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ProfessionDetailView(viewModel: .init(professionId: 202, professionApi: MockProfessionApi()))
	}
}
