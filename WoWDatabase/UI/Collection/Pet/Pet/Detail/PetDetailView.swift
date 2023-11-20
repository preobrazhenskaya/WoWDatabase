//
//  PetDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import SwiftUI

struct PetDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: PetDetailVM
	
	var body: some View {
		ScrollView {
			DetailCardMainView(title: viewModel.pet?.name,
							   icon: viewModel.petIcon,
							   iconLoading: viewModel.iconLoading.value,
							   description: viewModel.pet?.description,
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
			BoldColonRegularTextView(boldText: L10n.Professions.Detail.type,
									 regularText: viewModel.pet?.battlePetType?.name)
			BoldColonRegularTextView(boldText: L10n.Pet.Detail.isCapturable,
									 regularText: viewModel.pet?.isCapturableString)
			BoldColonRegularTextView(boldText: L10n.Pet.Detail.isTradable,
									 regularText: viewModel.pet?.isTradableString)
			BoldColonRegularTextView(boldText: L10n.Pet.Detail.isBattlepet,
									 regularText: viewModel.pet?.isBattlepetString)
			BoldColonRegularTextView(boldText: L10n.Pet.Detail.restrictions,
									 regularText: viewModel.pet?.restrictions)
			BoldColonRegularTextView(boldText: L10n.Title.Detail.source,
									 regularText: viewModel.pet?.source?.name)
			abilitiesView
				.padding(.top, 4)
		}
	}
	
	var abilitiesView: some View {
		VStack(alignment: .leading) {
			HStack {
				Spacer()
				Text(L10n.Pet.Detail.abilities)
					.bold()
				Spacer()
			}
			slotViewBuilder(slot: 0)
			slotViewBuilder(slot: 1)
			slotViewBuilder(slot: 2)
		}
	}
	
	func slotViewBuilder(slot: Int) -> some View {
		VStack(alignment: .leading) {
			BoldColonTextView(boldText: "\(L10n.Pet.Detail.slot) \(slot + 1)")
			if let abilities = viewModel.pet?.abilities(by: slot), !abilities.isEmpty {
				LazyVStack(alignment: .leading) {
					ForEach(abilities) { ability in
						let row = NameIdRow(model: .init(id: ability.ability?.id, name: "\(ability.ability?.name ?? "") (\(L10n.Pet.Detail.lvl) \(ability.requiredLevel ?? 0))"), backgroundColor: .backgroundLight)
						if let id = ability.ability?.id {
							NavigationLink(destination: {
								Router.navigate(to: .abilityDetail(id: id))
							}, label: {
								row
							})
						} else {
							row
						}
					}
				}
			} else {
				Text(L10n.General.no)
					.padding([.top, .bottom], 1)
			}
		}
	}
}

struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
		let db = PreviewService.createDbWithUser()
		let vm = PetDetailVM(petId: 39,
							 petApi: MockPetApi(),
							 dbService: DbService(db: db))
		return PetDetailView(viewModel: vm)
    }
}
