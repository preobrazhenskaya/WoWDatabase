//
//  AchievementRowBuilder.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 12.10.2023.
//

import SwiftUI

struct AchievementRowBuilder: View {
	var achievement: NameIdModel
	var backgroundColor: Color
	
	var body: some View {
		let row = NameIdRow(model: achievement, backgroundColor: backgroundColor)
		if let id = achievement.id {
			NavigationLink(destination: {
				Router.navigate(to: .achievementDetail(id: id))
			}, label: {
				row
			})
		} else {
			row
		}
	}
}

struct AchievementRowBuilder_Previews: PreviewProvider {
    static var previews: some View {
		AchievementRowBuilder(achievement: .init(id: 1, name: "Name"), backgroundColor: .background)
    }
}
