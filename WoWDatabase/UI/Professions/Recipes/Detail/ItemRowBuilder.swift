//
//  ItemRowBuilder.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

import SwiftUI

struct ItemRowBuilder: View {
	var item: NameIdModel
	
	var body: some View {
		let row = NameIdRow(model: item, backgroundColor: .backgroundLight)
		if let id = item.id {
			NavigationLink(destination: {
				Router.navigate(to: .itemDetail(id: id))
			}, label: {
				row
			})
		} else {
			row
		}
	}
}

struct ItemRowBuilder_Previews: PreviewProvider {
    static var previews: some View {
		ItemRowBuilder(item: .init(id: 1, name: "Name"))
    }
}
