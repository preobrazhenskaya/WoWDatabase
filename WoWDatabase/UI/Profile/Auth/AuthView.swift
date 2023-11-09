//
//  AuthView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 01.11.2023.
//

import SwiftUI

struct AuthView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: AuthVM
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				Text(L10n.Profile.userLogin)
					.foregroundColor(.textLight)
				TextField("", text: $viewModel.login)
					.padding(.all, 10)
					.background(Color.background)
					.cornerRadius(8)
					.foregroundColor(.textLight)
				Text(L10n.Profile.password)
					.foregroundColor(.textLight)
				TextField("", text: $viewModel.password)
					.padding(.all, 10)
					.background(Color.background)
					.cornerRadius(8)
					.foregroundColor(.textLight)
				ActionButton(action: { viewModel.auth() },
							 label: L10n.Profile.login)
				.padding(.top, 8)
			}
		}
		.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
		.setNavigationBar(title: L10n.Auth.title, dismiss: dismiss, showBack: true)
		.setViewBaseTheme()
		.withLoader(isLoading: viewModel.isLoading)
		.withErrorAlert(isPresented: $viewModel.showError,
						errorText: viewModel.errorText.value)
		.alert(
			L10n.General.ready,
			isPresented: $viewModel.showAuthMessage,
			actions: {
				Button(L10n.General.ok) {
					dismiss()
				}
			}, message: {
				Text(L10n.Auth.success)
			}
		)
	}
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
		AuthView(viewModel: .init(db: PreviewService.createDbWithUser()))
    }
}
