//
//  RecipeRowBuilder.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import SwiftUI

struct RecipeRowBuilder: View {
	var recipe: NameIdModel
	
	var body: some View {
		let row = NameIdRow(model: recipe, backgroundColor: .background)
		if let id = recipe.id {
			NavigationLink(destination: {
				Router.navigate(to: .recipeDetail(id: id))
			}, label: {
				row
			})
		} else {
			row
		}
	}
}

struct RecipeRowBuilder_Previews: PreviewProvider {
	static var previews: some View {
		RecipeRowBuilder(recipe: .init(id: 1, name: "Name"))
	}
}
