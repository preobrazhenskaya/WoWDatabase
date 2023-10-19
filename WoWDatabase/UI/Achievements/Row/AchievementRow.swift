//
//  AchievementRow.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 29.09.2023.
//

import SwiftUI

struct AchievementRow: View {
	var achievement: AchievementShortModel
	var backgroundColor: Color
	
	var background: some View {
		backgroundColor
			.cornerRadius(6)
	}
	
	var titleText: some View {
		Text(achievement.name ?? "")
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
				if achievement.id != nil {
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
		AchievementRow(achievement: .init(id: 1, name: "Name"), backgroundColor: .backgroundAccent)
    }
}
