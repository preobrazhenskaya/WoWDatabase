//
//  ToyDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import SwiftUI

struct ToyDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: ToyDetailVM
	
	var body: some View {
		ScrollView {
			DetailCardMainView(title: viewModel.toy?.item?.name,
							   icon: viewModel.toyIcon,
							   iconLoading: viewModel.iconLoading.value,
							   description: nil,
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
			BoldColonRegularTextView(boldText: L10n.Title.Detail.source,
									 regularText: viewModel.toy?.source?.name)
			Text(viewModel.toy?.sourceDescription ?? "")
			itemView
				.padding(.top, 4)
		}
	}
	
	@ViewBuilder
	var itemView: some View {
		if let item = viewModel.toy?.item {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Toy.Detail.item)
				let row = NameIdRow(model: item, backgroundColor: .backgroundLight)
				if let id = item.id {
					NavigationLink(destination: {
						Router.navigate(to: .itemDetail(id: id))
					}, label: {
						row
					})
				} else {
					row
				}
			}
		}
	}
}

struct ToyDetailView_Previews: PreviewProvider {
    static var previews: some View {
		let db = PreviewService.createDbWithUser()
		let vm = ToyDetailVM(toyId: 245, toyApi: MockToyApi(), dbService: DbService(db: db))
		return ToyDetailView(viewModel: vm)
    }
}
