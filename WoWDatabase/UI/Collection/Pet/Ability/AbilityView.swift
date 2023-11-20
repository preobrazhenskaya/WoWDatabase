//
//  AbilityView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import SwiftUI

struct AbilityView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: AbilityVM
	
	var body: some View {
		ScrollView {
			DetailCardMainView(title: viewModel.ability?.name,
							   icon: viewModel.abilityIcon,
							   iconLoading: viewModel.iconLoading.value,
							   description: nil,
							   descriptionView: descriptionView,
							   withFav: false,
							   inFav: false,
							   removeFromFavorites: { },
							   addInFavorites: { })
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
	}
	
	var descriptionView: some View {
		VStack(alignment: .leading) {
			BoldColonRegularTextView(boldText: L10n.Professions.Detail.type,
									 regularText: viewModel.ability?.battlePetType?.name)
			BoldColonRegularTextView(boldText: L10n.Ability.Detail.cooldown,
									 regularText: "\(L10n.Ability.Detail.roundsCount(viewModel.ability?.cooldown ?? 0))")
			BoldColonRegularTextView(boldText: L10n.Ability.Detail.rounds,
									 regularText: "\(L10n.Ability.Detail.roundsCount(viewModel.ability?.rounds ?? 0))")
		}
	}
}

struct AbilityView_Previews: PreviewProvider {
    static var previews: some View {
		AbilityView(viewModel: AbilityVM(abilityId: 110, petApi: MockPetApi()))
    }
}
