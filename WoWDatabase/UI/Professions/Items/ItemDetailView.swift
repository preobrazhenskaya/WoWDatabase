//
//  ItemDetailView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

import SwiftUI

struct ItemDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@ObservedObject var viewModel: ItemDetailVM
	
	var body: some View {
		ScrollView { mainView }
			.setNavigationBar(title: "", dismiss: dismiss, showBack: true)
			.toolbarBackground(.hidden, for: .navigationBar)
			.toolbar(.hidden, for: .tabBar)
			.setViewBaseTheme()
			.withLoader(isLoading: viewModel.isLoading)
			.withErrorAlert(isPresented: $viewModel.showError,
							errorText: viewModel.errorText.value)
			.onFirstAppear { viewModel.loadData() }
			.refreshable { viewModel.loadData() }
	}
	
	var mainView: some View {
		ZStack {
			CardBackgroundView()
				.padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
			cardView
		}
		.foregroundColor(.textMain)
		.padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
	}
	
	var cardView: some View {
		VStack(alignment: .center) {
			CardTitleView(title: viewModel.item?.name)
			CardImageView(iconUrl: viewModel.itemIcon,
						  iconLoading: viewModel.mediaLoading.value)
			if let description = viewModel.item?.description {
				MultilineText(text: description, alignment: .center)
			}
			descriptionView
		}
		.padding(.init(top: 6, leading: 16, bottom: 16, trailing: 16))
	}
	
	var descriptionView: some View {
		VStack(alignment: .leading) {
			descriptionText
			BoldColonRegularTextView(
				boldText: L10n.Item.Detail.quality,
				regularText: viewModel.item?.quality?.name
			)
			.padding(.top, 4)
			BoldColonRegularTextView(
				boldText: L10n.Item.Detail.itemLevel,
				regularText: viewModel.item?.levelString
			)
			typeText
				.padding(.top, 4)
			equipView
				.padding(.top, 4)
			requirementsView
				.padding(.top, 4)
			sellPrice
				.padding(.top, 4)
			
		}
		.padding(.top, 4)
		.frame(minWidth: 0,
			   maxWidth: .infinity,
			   minHeight: 0,
			   maxHeight: .infinity,
			   alignment: .topLeading)
	}
	
	var descriptionText: some View {
		VStack(alignment: .leading) {
			if let binding = viewModel.item?.previewItem?.binding?.name {
				MultilineText(text: binding, alignment: .leading)
			}
			ForEach(viewModel.item?.previewItem?.spells ?? []) { spell in
				if let spell = spell.description {
					MultilineText(text: spell, alignment: .leading)
				}
			}
		}
	}
	
	var typeText: some View {
		var strings = [String]()
		if let itemClass = viewModel.item?.itemClass, let name = itemClass.name {
			strings.append(name)
		}
		if let itemSubclass = viewModel.item?.itemSubclass, let name = itemSubclass.name {
			strings.append(name)
		}
		if let inventoryType = viewModel.item?.inventoryType, let name = inventoryType.name {
			strings.append(name)
		}
		let resultString = strings.map { $0 }.joined(separator: " - ")
		
		return MultilineText(text: resultString, alignment: .leading)
	}
	
	@ViewBuilder
	var equipView: some View {
		if let durability = viewModel.item?.previewItem?.durability?.displayString {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Item.Detail.equipStats)
				if let weapon = viewModel.item?.previewItem?.weapon {
					HStack {
						Text(weapon.damage?.displayString ?? "")
						Spacer()
						Text(weapon.attackSpeed?.displayString ?? "")
					}
					Text(weapon.dps?.displayString ?? "")
				}
				if let armor = viewModel.item?.previewItem?.armor {
					Text(armor.display?.displayString ?? "")
				}
				ForEach(viewModel.item?.previewItem?.stats ?? []) { stat in
					Text(stat.display?.displayString ?? "")
				}
				Text(durability)
			}
		}
	}
	
	@ViewBuilder
	var requirementsView: some View {
		if let requirements = viewModel.item?.previewItem?.requirements {
			VStack(alignment: .leading) {
				BoldColonTextView(boldText: L10n.Item.Detail.requirements)
				Text(requirements.level?.displayString ?? "")
				MultilineText(text: requirements.skill?.displayString ?? "",
							  alignment: .leading)
			}
		}
	}
	
	var sellPrice: some View {
		HStack {
			BoldColonTextView(boldText: L10n.Item.Detail.sellPrice)
			Text(viewModel.item?.previewItem?.sellPrice?.displayStrings?.gold ?? "0")
			Image(asset: Asset.Money.gold)
				.resizable()
				.scaledToFill()
				.frame(width: 15, height: 15)
			Text(viewModel.item?.previewItem?.sellPrice?.displayStrings?.silver ?? "0")
			Image(asset: Asset.Money.silver)
				.resizable()
				.scaledToFill()
				.frame(width: 15, height: 15)
			Text(viewModel.item?.previewItem?.sellPrice?.displayStrings?.copper ?? "0")
			Image(asset: Asset.Money.copper)
				.resizable()
				.scaledToFill()
				.frame(width: 15, height: 15)
		}
	}
}

struct ItemDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ItemDetailView(viewModel: .init(id: 153490, professionApi: MockProfessionApi()))
	}
}
