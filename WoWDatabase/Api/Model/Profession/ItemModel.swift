//
//  ItemModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

struct ItemModel: Codable {
	let id: Int?
	let name: String?
	let quality: TypeNameModel?
	let level: Int?
	let itemClass: NameIdModel?
	let itemSubclass: NameIdModel?
	let inventoryType: TypeNameModel?
	let description: String?
	let previewItem: ItemPreviewModel?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case quality
		case level
		case itemClass = "item_class"
		case itemSubclass = "item_subclass"
		case inventoryType = "inventory_type"
		case description
		case previewItem = "preview_item"
	}
	
	var levelString: String {
		guard let level = level else { return "-" }
		return "\(level)"
	}
}

struct ItemPreviewModel: Codable {
	let binding: TypeNameModel?
	let weapon: ItemPreviewWeaponModel?
	let armor: DisplayModel?
	let stats: [DisplayModel]?
	let spells: [ItemPreviewSpellModel]?
	let sellPrice: ItemPreviewPriceModel?
	let requirements: ItemPreviewRequirementsModel?
	let durability: DisplayStringModel?
	
	private enum CodingKeys: String, CodingKey {
		case binding
		case weapon
		case armor
		case stats
		case spells
		case sellPrice = "sell_price"
		case requirements
		case durability
	}
}

struct ItemPreviewWeaponModel: Codable {
	let damage: DisplayStringModel?
	let attackSpeed: DisplayStringModel?
	let dps: DisplayStringModel?
	
	private enum CodingKeys: String, CodingKey {
		case damage
		case attackSpeed = "attack_speed"
		case dps
	}
}

struct ItemPreviewSpellModel: Codable, Identifiable {
	var id: String {
		description ?? ""
	}
	
	let description: String?
}

struct ItemPreviewPriceModel: Codable {
	let displayStrings: ItemPreviewPriceStringsModel?
	
	private enum CodingKeys: String, CodingKey {
		case displayStrings = "display_strings"
	}
}

struct ItemPreviewPriceStringsModel: Codable {
	let header: String?
	let gold: String?
	let silver: String?
	let copper: String?
}

struct ItemPreviewRequirementsModel: Codable {
	let level: DisplayStringModel?
	let skill: DisplayStringModel?
}
