//
//  ProfileView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 19.10.2023.
//

import SwiftUI

struct ProfileView: View {
	@ObservedObject var viewModel: ProfileViewModel
	
	var body: some View {
		NavigationStack {
			VStack {
				Button(action: {
					viewModel.updateToken()
				}, label: {
					ZStack {
						Color.backgroundDark
						Text(L10n.Profile.updateToken)
							.foregroundColor(.white)
					}
				})
				.frame(height: 52)
				.cornerRadius(10)
				Spacer()
			}
			.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
			.setNavigationBar(title: L10n.Tab.profile, dismiss: nil, showBack: false)
			.setViewBaseTheme()
			.withLoader(isLoading: viewModel.isLoading)
			.withErrorAlert(isPresented: $viewModel.showError, errorText: viewModel.errorText.value)
		}
	}
}

struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		ProfileView(viewModel: .init())
	}
}
