//
//  MountListView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.11.2023.
//

import SwiftUI

struct MountListView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: MountListVM
	
	var body: some View {
		ScrollView { mainView }
			.setNavigationBar(title: L10n.Mount.title, dismiss: dismiss, showBack: true)
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
			ForEach(viewModel.mounts) { mount in
				let row = NameIdRow(model: mount, backgroundColor: .background)
				if let id = mount.id {
					NavigationLink(destination: {
						Router.navigate(to: .mountDetail(id: id))
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

struct MountListView_Previews: PreviewProvider {
    static var previews: some View {
		MountListView(viewModel: MountListVM(mountApi: MockMountApi()))
    }
}
