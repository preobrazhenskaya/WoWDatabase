//
//  ProfileView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 19.10.2023.
//

import SwiftUI

struct ProfileView: View {
	@ObservedObject var viewModel: ProfileVM
	
	var body: some View {
		NavigationStack {
			ScrollView {
				if let user = viewModel.currentUser {
					Text(user.login ?? "")
						.font(.customBoldLargeTitle)
					NavigationLink(destination: {
						Router.navigate(to: .favorites)
					}, label: {
						NameIdRow(model: .init(id: 1, name: L10n.Fav.title), backgroundColor: .background)
					})
					ActionButton(action: { viewModel.logout() },
								 label: L10n.Profile.logout)
				} else {
					NavigationButton(destination: .auth,
									 label: L10n.Profile.login)
					NavigationButton(destination: .registration,
									 label: L10n.Profile.register)
				}
				ActionButton(action: { viewModel.updateToken() },
							 label: L10n.Profile.updateToken)
			}
			.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
			.setNavigationBar(title: L10n.Tab.profile, dismiss: nil, showBack: false)
			.setViewBaseTheme()
			.withLoader(isLoading: viewModel.isLoading)
			.withErrorAlert(isPresented: $viewModel.showError,
							errorText: viewModel.errorText.value)
			.onAppear { viewModel.getActiveUser() }
		}
	}
}

struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		let db = PreviewService.createDbWithUser()
		let vm = ProfileVM(dbService: DbService(db: db))
		return ProfileView(viewModel: vm)
	}
}
