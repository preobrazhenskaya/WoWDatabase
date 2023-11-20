//
//  DetailCardMainView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 13.11.2023.
//

import SwiftUI

struct DetailCardMainView<Content: View>: View {
	var title: String?
	var icon: URL?
	var iconLoading: Bool
	var description: String?
	var descriptionView: Content
	var withFav: Bool
	var inFav: Bool
	var removeFromFavorites: () -> Void
	var addInFavorites: () -> Void
	
	var body: some View {
		VStack {
			MultilineText(text: title ?? "", alignment: .center)
				.font(.customBoldLargeTitle)
			ZStack {
				ZStack(alignment: .top) {
					Color.background
						.cornerRadius(6)
					if withFav {
						HStack {
							Spacer()
							FavoriteImage(inFav: inFav,
										  removeFromFavorites: removeFromFavorites,
										  addInFavorites: addInFavorites)
						}
						.padding([.top, .trailing], 16)
					}
				}
				.padding(.top, 103)
				cardView
			}
		}
		.foregroundColor(.textLight)
		.padding([.leading, .trailing], 16)
	}
	
	var cardView: some View {
		VStack(alignment: .center) {
			iconView
			if let description = description {
				MultilineText(text: description, alignment: .center)
					.padding(.top, 6)
			}
			descriptionView
				.padding(.top, 4)
				.frame(minWidth: 0,
					   maxWidth: .infinity,
					   minHeight: 0,
					   maxHeight: .infinity,
					   alignment: .topLeading)
		}
		.padding(.init(top: 6, leading: 16, bottom: 16, trailing: 16))
	}
	
	var iconView: some View {
		AsyncImage(url: icon) { phase in
			let defaultImage = Image(systemSymbol: .photo)
				.resizable()
				.scaledToFit()
			switch phase {
			case .empty:
				if !iconLoading && icon == nil {
					defaultImage
				} else {
					CustomProgressView(isLoading: true)
				}
			case let .success(image):
				ZStack {
					image
						.resizable()
						.scaledToFill()
						.frame(width: 200, height: 200)
					RoundedRectangle(cornerRadius: 10)
						.stroke(LinearGradient(
							colors: [Color.borderStart,
									 Color.borderEnd],
							startPoint: .topLeading,
							endPoint: .bottomTrailing
						), lineWidth: 5)
				}
			default:
				defaultImage
			}
		}
		.frame(width: 206, height: 206)
	}
}

struct DetailCardView_Previews: PreviewProvider {
	static var previews: some View {
		ScrollView {
			DetailCardMainView(title: "DetailCardView",
							   icon: URL(string: "https://render.worldofwarcraft.com/eu/icons/56/inv_misc_elvencoins.jpg"),
							   iconLoading: false,
							   description: "DetailCardView description",
							   descriptionView: EmptyView(),
							   withFav: true,
							   inFav: true,
							   removeFromFavorites: {},
							   addInFavorites: {})
		}
		.background(
			Image(asset: Asset.background)
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()
				.blur(radius: 2)
		)
	}
}
