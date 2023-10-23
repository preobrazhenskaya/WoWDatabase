//
//  ProfessionRowBuilder.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import SwiftUI

struct ProfessionRowBuilder: View {
	var profession: NameIdModel
	var backgroundColor: Color
	
	var body: some View {
		let row = NameIdRow(model: profession, backgroundColor: backgroundColor)
		if let id = profession.id {
			NavigationLink(destination: {
				Router.navigate(to: .professionDetail(id: id))
			}, label: {
				row
			})
		} else {
			row
		}
	}
}

struct ProfessionRowBuilder_Previews: PreviewProvider {
    static var previews: some View {
		ProfessionRowBuilder(profession: .init(id: 1, name: "Name"), backgroundColor: .background)
    }
}
