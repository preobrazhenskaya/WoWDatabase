//
//  RegistrationView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 31.10.2023.
//

import SwiftUI

struct RegistrationView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: RegistrationVM
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				Text(L10n.Profile.login)
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
				ActionButton(action: {  },
							 label: L10n.Profile.register)
				.padding(.top, 8)
			}
		}
		.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
		.setNavigationBar(title: L10n.Profile.registration, dismiss: dismiss, showBack: true)
		.setViewBaseTheme()
		.withLoader(isLoading: viewModel.isLoading)
		.withErrorAlert(isPresented: $viewModel.showError,
						errorText: viewModel.errorText.value)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
		RegistrationView(viewModel: .init())
    }
}