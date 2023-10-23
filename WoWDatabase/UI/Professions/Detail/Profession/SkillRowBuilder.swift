//
//  SkillRowBuilder.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import SwiftUI

struct SkillRowBuilder: View {
	var skill: NameIdModel
	var professionId: Int
	
	var body: some View {
		let row = NameIdRow(model: skill, backgroundColor: .backgroundLight)
		if let id = skill.id {
			NavigationLink(destination: {
				Router.navigate(to: .skillDetail(skillId: id, professionId: professionId))
			}, label: {
				row
			})
		} else {
			row
		}
	}
}

struct SkillRowBuilder_Previews: PreviewProvider {
    static var previews: some View {
		SkillRowBuilder(skill: .init(id: 1, name: "Name"), professionId: 1)
    }
}
