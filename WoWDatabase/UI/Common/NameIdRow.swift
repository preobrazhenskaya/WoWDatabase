//
//  NameIdRow.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 29.09.2023.
//

import SwiftUI

struct NameIdRow: View {
	var model: NameIdModel
	var backgroundColor: Color
	
	var background: some View {
		backgroundColor
			.cornerRadius(6)
	}
	
	var titleText: some View {
		Text(model.name ?? "")
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.leading)
	}
	
	var navigationImage: some View {
		Image(systemSymbol: .chevronForward)
	}
	
    var body: some View {
		ZStack {
			background
			HStack {
				titleText
				Spacer()
				if model.id != nil {
					navigationImage
				}
			}
			.foregroundColor(.textMain)
			.padding(.all)
		}
    }
}

struct AchievementRow_Previews: PreviewProvider {
    static var previews: some View {
		NameIdRow(model: .init(id: 1, name: "Name"), backgroundColor: .background)
    }
}
