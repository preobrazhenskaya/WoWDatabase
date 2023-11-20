//
//  PetListView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import SwiftUI

struct PetListView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: PetListVM
	
	var body: some View {
		ScrollView { mainView }
			.setNavigationBar(title: L10n.Pet.title, dismiss: dismiss, showBack: true)
			.toolbar(.hidden, for: .tabBar)
			.setViewBaseTheme()
			.withLoader(isLoading: viewModel.isLoading)
			.withErrorAlert(isPresented: $viewModel.showError,
							errorText: viewModel.errorText.value)
			.onFirstAppear { viewModel.loadData() }
			.refreshable { viewModel.loadData() }
	}
	
	var mainView: some View {
		LazyVStack {
			ForEach(viewModel.pets) { pet in
				let row = NameIdRow(model: pet, backgroundColor: .background)
				if let id = pet.id {
					NavigationLink(destination: {
						Router.navigate(to: .petDetail(id: id))
					}, label: {
						row
					})
				} else {
					row
				}
			}
		}
		.padding(.all)
	}
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
		PetListView(viewModel: PetListVM(petApi: MockPetApi()))
    }
}
