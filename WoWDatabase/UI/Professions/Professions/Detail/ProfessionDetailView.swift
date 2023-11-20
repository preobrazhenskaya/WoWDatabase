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
		ScrollView {
			DetailCardMainView(title: viewModel.profession?.name,
							   icon: viewModel.professionIcon,
							   iconLoading: viewModel.mediaLoading.value,
							   description: viewModel.profession?.description,
							   descriptionView: descriptionView,
							   withFav: true,
							   inFav: viewModel.inFav,
							   removeFromFavorites: { viewModel.removeFromFavorites() },
							   addInFavorites: { viewModel.addInFavorites() })
		}
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
	
	var descriptionView: some View {
		VStack(alignment: .leading) {
			BoldColonRegularTextView(
				boldText: L10n.Professions.Detail.type,
				regularText: viewModel.profession?.type?.name
			)
			skillList
				.padding(.top, 4)
		}
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
		let db = PreviewService.createDbWithUser()
		let vm = ProfessionDetailVM(professionId: 202,
									professionApi: MockProfessionApi(),
									dbService: DbService(db: db))
		return ProfessionDetailView(viewModel: vm)
	}
}
