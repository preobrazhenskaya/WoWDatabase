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
			VStack {
				NavigationButton(destination: .auth,
								 label: L10n.Profile.login)
				NavigationButton(destination: .registration,
								 label: L10n.Profile.register)
				ActionButton(action: { viewModel.updateToken() },
							 label: L10n.Profile.updateToken)
				Spacer()
			}
			.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
			.setNavigationBar(title: L10n.Tab.profile, dismiss: nil, showBack: false)
			.setViewBaseTheme()
			.withLoader(isLoading: viewModel.isLoading)
			.withErrorAlert(isPresented: $viewModel.showError,
							errorText: viewModel.errorText.value)
		}
	}
}

struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileView(viewModel: .init())
	}
}
