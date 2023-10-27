//
//  ProfessionDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import SwiftUI

struct ProfessionDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: ProfessionDetailVM
	
	var background: some View {
		Color.background
			.cornerRadius(6)
			.padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
	}
	
	var titleText: some View {
		Text(viewModel.profession?.name ?? "")
			.font(.customBoldLargeTitle)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
	}
	
	var mainImage: some View {
		AsyncImage(url: viewModel.professionIcon) { phase in
			let defaultImage = Image(systemSymbol: .photo)
				.resizable()
				.scaledToFit()
			switch phase {
			case .empty:
				if !viewModel.mediaLoading.value && viewModel.professionIcon == nil {
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
		Text(viewModel.profession?.description ?? "")
			.padding(.top, 6)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
	}
	
	var typeText: some View {
		HStack {
			Text("\(L10n.Professions.Detail.type):")
				.bold()
			Text(viewModel.profession?.type?.name ?? "")
		}
		.padding(.top, 4)
	}
	
	var skillList: some View {
		VStack(alignment: .leading) {
			Text("\(L10n.Professions.Detail.skills):")
				.bold()
				.padding(.top, 4)
			LazyVStack(alignment: .leading) {
				ForEach(viewModel.profession?.skillTiers ?? []) { skill in
					SkillRowBuilder(skill: skill, professionId: viewModel.professionId)
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
						typeText
						if !(viewModel.profession?.skillTiers?.isEmpty ?? true) {
							skillList
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

struct ProfessionDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ProfessionDetailView(viewModel: .init(professionId: 202, professionApi: MockProfessionApi()))
	}
}
