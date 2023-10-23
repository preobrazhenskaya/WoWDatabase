//
//  ProfessionsListView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import SwiftUI

struct ProfessionsListView: View {
	@ObservedObject var viewModel: ProfessionsListVM
	
    var body: some View {
		NavigationStack {
			ScrollView {
				LazyVStack {
					ForEach(viewModel.professions) { profession in
						ProfessionRowBuilder(profession: profession)
					}
				}
				.padding(.all)
			}
			.setNavigationBar(title: L10n.Tab.professions, dismiss: nil, showBack: false)
			.setViewBaseTheme()
			.withLoader(isLoading: viewModel.isLoading)
			.withErrorAlert(isPresented: $viewModel.showError, errorText: viewModel.errorText.value)
			.onFirstAppear { viewModel.loadData() }
			.refreshable { viewModel.loadData() }
		}
    }
}

struct ProfessionsListView_Previews: PreviewProvider {
    static var previews: some View {
		ProfessionsListView(viewModel: .init())
    }
}