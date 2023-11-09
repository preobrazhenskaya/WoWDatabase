//
//  EmptySearchView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 09.11.2023.
//

import SwiftUI

struct EmptySearchView: View {
    var body: some View {
		VStack(alignment: .center) {
			Image(systemSymbol: .magnifyingglass)
				.resizable()
				.scaledToFill()
				.frame(width: 34, height: 34)
			Text(L10n.General.emptySearch)
				.font(.custom(FontFamily.FrizQuadrataC.regular, size: 24))
		}
    }
}

struct EmptySearchView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySearchView()
    }
}
