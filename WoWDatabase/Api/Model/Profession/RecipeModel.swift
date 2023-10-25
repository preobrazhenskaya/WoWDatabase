//
//  RecipeModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

struct RecipeModel: Codable {
	let id: Int?
	let name: String?
	let description: String?
	let craftedItem: NameIdModel?
	let allianceCraftedItem: NameIdModel?
	let hordeCraftedItem: NameIdModel?
	let reagents: [RecipeReagentModel]?
	let rank: Int?
	let craftedQuantity: RecipeCraftedQuantityModel?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case description
		case craftedItem = "crafted_item"
		case allianceCraftedItem = "alliance_crafted_item"
		case hordeCraftedItem = "horde_crafted_item"
		case reagents
		case craftedQuantity = "crafted_quantity"
		case rank
	}
	
	var rankString: String {
		guard let rank = rank else { return "-" }
		return "\(rank)"
	}
}

struct RecipeReagentModel: Codable, Identifiable {
	var id: String {
		reagent?.name ?? ""
	}
	
	let reagent: NameIdModel?
	let quantity: Int?
}

struct RecipeCraftedQuantityModel: Codable {
	let value: Int?
}
