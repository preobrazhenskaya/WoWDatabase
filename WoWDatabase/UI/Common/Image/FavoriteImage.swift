//
//  FavoriteImage.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

import SwiftUI

struct FavoriteImage: View {
	var inFav: Bool
	var removeFromFavorites: () -> Void
	var addInFavorites: () -> Void
	
    var body: some View {
		Button(action: {
			inFav ? removeFromFavorites() : addInFavorites()
		}, label: {
			Image(systemSymbol: inFav ? .heartFill : .heart)
				.resizable()
				.scaledToFill()
				.frame(width: 32, height: 32)
		})
    }
}

struct FavoriteImage_Previews: PreviewProvider {
    static var previews: some View {
		FavoriteImage(inFav: true,
					  removeFromFavorites: {},
					  addInFavorites: {})
    }
}
