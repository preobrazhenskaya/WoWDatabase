//
//  RecipeDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

import SwiftUI

struct RecipeDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: RecipeDetailVM
	
	var background: some View {
		Color.background
			.cornerRadius(6)
			.padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
	}
	
	var titleText: some View {
		Text(viewModel.recipe?.name ?? "")
			.font(.customBoldLargeTitle)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
	}
	
	var mainImage: some View {
		AsyncImage(url: viewModel.recipeIcon) { phase in
			let defaultImage = Image(systemSymbol: .photo)
				.resizable()
				.scaledToFit()
			switch phase {
			case .empty:
				if !viewModel.mediaLoading.value && viewModel.recipeIcon == nil {
					defaultImage
				} else {
					CustomProgressView(isLoading: true)
				}
			case let .success(image):
				ZStack {
					image
						.resizable()
						.scaledToFill()
						.cornerRadius(10)
						.frame(width: 200, height: 200)
					RoundedRectangle(cornerRadius: 10)
						.stroke(
							LinearGradient(
								colors: [Color.borderStart,
										 Color.borderEnd],
								startPoint: .topLeading,
								endPoint: .bottomTrailing
							),
							lineWidth: 5
						)
				}
			default:
				defaultImage
			}
		}
		.frame(width: 205, height: 205)
	}
	
	var descriptionText: some View {
		Text(viewModel.recipe?.description ?? "")
			.padding(.top, 6)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
	}
	
	var rankText: some View {
		HStack {
			Text("\(L10n.Recipe.Detail.rank):")
				.bold()
			Text(viewModel.recipe?.rankString ?? "-")
		}
		.padding(.top, 4)
	}
	
	var itemView: some View {
		VStack(alignment: .leading) {
			if let item = viewModel.recipe?.craftedItem {
				NameIdRow(model: .init(id: item.id, name: "\(item.name ?? "") (\(viewModel.recipe?.craftedQuantity?.value ?? 0))"), backgroundColor: .backgroundLight)
			}
			if let item = viewModel.recipe?.allianceCraftedItem {
				NameIdRow(model: .init(id: item.id, name: "\(item.name ?? "") (\(viewModel.recipe?.craftedQuantity?.value ?? 0)) (\(L10n.General.alliance))"), backgroundColor: .backgroundLight)
			}
			if let item = viewModel.recipe?.hordeCraftedItem {
				NameIdRow(model: .init(id: item.id, name: "\(item.name ?? "") (\(viewModel.recipe?.craftedQuantity?.value ?? 0)) (\(L10n.General.horde))"), backgroundColor: .backgroundLight)
			}
		}
	}
	
	func reagentsView(_ reagents: [RecipeReagentModel]) -> some View {
		VStack(alignment: .leading) {
			Text("\(L10n.Recipe.Detail.reagents):")
				.bold()
				.padding(.top, 4)
			LazyVStack(alignment: .leading) {
				ForEach(reagents) { reagent in
					if let reagentModel = reagent.reagent {
						NameIdRow(model: .init(id: reagentModel.id, name: "\(reagentModel.name ?? "") (\(reagent.quantity ?? 0))"), backgroundColor: .backgroundLight)
					}
				}
			}
		}
	}
	
    var body: some View {
		ScrollView {
			ZStack {
				background
				VStack(alignment: .center) {
					titleText
					mainImage
					descriptionText
					VStack(alignment: .leading) {
						rankText
						itemView
						if let reagents = viewModel.recipe?.reagents {
							reagentsView(reagents)
						}
					}
					.frame(minWidth: 0,
						   maxWidth: .infinity,
						   minHeight: 0,
						   maxHeight: .infinity,
						   alignment: .topLeading)
				}
				.padding(.init(top: 6, leading: 16, bottom: 16, trailing: 16))
			}
			.foregroundColor(.textMain)
			.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
		}
		.setNavigationBar(title: "", dismiss: dismiss, showBack: true)
		.toolbarBackground(.hidden, for: .navigationBar)
		.toolbar(.hidden, for: .tabBar)
		.setViewBaseTheme()
		.withLoader(isLoading: viewModel.isLoading)
		.withErrorAlert(isPresented: $viewModel.showError, errorText: viewModel.errorText.value)
		.onFirstAppear { viewModel.loadData() }
		.refreshable { viewModel.loadData() }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
		RecipeDetailView(viewModel: .init(id: 42347, professionApi: MockProfessionApi()))
    }
}
