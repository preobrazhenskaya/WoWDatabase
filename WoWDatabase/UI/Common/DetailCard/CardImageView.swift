//
//  CardImageView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 27.10.2023.
//

import SwiftUI

struct CardImageView: View {
	var iconUrl: URL?
	var iconLoading: Bool
	
	var body: some View {
		AsyncImage(url: iconUrl) { phase in
			let defaultImage = Image(systemSymbol: .photo)
				.resizable()
				.scaledToFit()
			switch phase {
			case .empty:
				if !iconLoading && iconUrl == nil {
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
}

struct CardImageView_Previews: PreviewProvider {
	static var previews: some View {
		CardImageView(iconUrl: URL(string: "https://render.worldofwarcraft.com/eu/icons/56/inv_misc_elvencoins.jpg"),
					  iconLoading: false)
	}
}
