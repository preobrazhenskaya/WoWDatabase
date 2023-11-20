//
//  ToyListView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import SwiftUI

struct ToyListView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: ToyListVM
	
	var body: some View {
		ScrollView { mainView }
			.setNavigationBar(title: L10n.Toy.title, dismiss: dismiss, showBack: true)
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
			ForEach(viewModel.toys) { toy in
				let row = NameIdRow(model: toy, backgroundColor: .background)
				if let id = toy.id {
					NavigationLink(destination: {
						Router.navigate(to: .toyDetail(id: id))
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

struct ToyListView_Previews: PreviewProvider {
    static var previews: some View {
		ToyListView(viewModel: ToyListVM(toyApi: MockToyApi()))
    }
}
