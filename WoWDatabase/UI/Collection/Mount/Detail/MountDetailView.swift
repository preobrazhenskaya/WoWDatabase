//
//  MountDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.11.2023.
//

import SwiftUI

struct MountDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: MountDetailVM
	
    var body: some View {
		ScrollView {
			DetailCardMainView(title: viewModel.mount?.name,
							   icon: viewModel.mountIcon,
							   iconLoading: viewModel.iconLoading.value,
							   description: viewModel.mount?.description,
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
			BoldColonRegularTextView(boldText: L10n.Title.Detail.source, regularText: viewModel.mount?.source?.name)
			BoldColonRegularTextView(boldText: L10n.Achievements.Detail.faction, regularText: viewModel.mount?.faction?.name)
			BoldColonRegularTextView(boldText: L10n.Item.Detail.requirements, regularText: viewModel.mount?.requirements?.faction?.name)
		}
	}
}

struct MountDetailView_Previews: PreviewProvider {
    static var previews: some View {
		let db = PreviewService.createDbWithUser()
		let vm = MountDetailVM(mountId: 6,
							   mountApi: MockMountApi(),
							   dbService: DbService(db: db))
		return MountDetailView(viewModel: vm)
    }
}
