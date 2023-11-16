//
//  TitleListView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

import SwiftUI

struct TitleListView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: TitleListVM
	
	var body: some View {
		ScrollView { mainView }
			.setNavigationBar(title: L10n.Title.title, dismiss: dismiss, showBack: true)
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
			ForEach(viewModel.titles) { title in
				let row = NameIdRow(model: title, backgroundColor: .background)
				if let id = title.id {
					NavigationLink(destination: {
						Router.navigate(to: .titleDetail(id: id))
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

struct TitleListView_Previews: PreviewProvider {
    static var previews: some View {
		TitleListView(viewModel: TitleListVM(titleApi: MockTitleApi()))
    }
}
