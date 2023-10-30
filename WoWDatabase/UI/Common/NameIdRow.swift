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
	
	var body: some View {
		ZStack {
			backgroundColor
				.cornerRadius(6)
			HStack {
				MultilineText(text: model.name ?? "", alignment: .leading)
				Spacer()
				if model.id != nil {
					Image(systemSymbol: .chevronForward)
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
