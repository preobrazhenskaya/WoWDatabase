//
//  CollectionView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 15.11.2023.
//

import SwiftUI

struct CollectionView: View {
	@ObservedObject var viewModel: CollectionVM
	@State private var rowHeight: CGFloat = 0
	
	var body: some View {
		NavigationStack {
			ScrollView { mainView }
				.setNavigationBar(title: L10n.Collection.title, dismiss: nil, showBack: false)
				.setViewBaseTheme()
		}
	}
	
	var mainView: some View {
		LazyVGrid(columns: [.init(.adaptive(minimum: 100))]) {
			ForEach(viewModel.rows, id: \.self.0) { row in
				NavigationLink(destination: {
					Router.navigate(to: row.2)
				}, label: {
					createRow(title: row.0, image: row.1)
				})
			}
		}
		.padding(.all, 16)
	}
	
	func createRow(title: String, image: Image) -> some View {
		ZStack {
			Color.background
			VStack(alignment: .center, spacing: 8) {
				image
					.resizable()
					.frame(width: 32, height: 32)
					.scaledToFill()
					.foregroundColor(.textLight)
				MultilineText(text: title, alignment: .center)
					.font(.custom(FontFamily.FrizQuadrataC.regular, fixedSize: 16))
					.foregroundColor(.textLight)
			}
			.padding(.all, 10)
		}
		.cornerRadius(4)
		.background {
			GeometryReader { geometry in
				Path { _ in
					rowHeight = geometry.size.width
				}
			}
		}
		.frame(height: rowHeight)
	}
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
		CollectionView(viewModel: CollectionVM())
    }
}
