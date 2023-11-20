//
//  PetModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct PetModel: Codable {
	let id: Int?
	let name: String?
	let battlePetType: PetBattleTypeModel?
	let description: String?
	let isCapturable: Bool?
	let isTradable: Bool?
	let isBattlepet: Bool?
	let isAllianceOnly: Bool?
	let isHordeOnly: Bool?
	let abilities: [PetAbilityModel]?
	let source: TypeNameModel?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case battlePetType = "battle_pet_type"
		case description
		case isCapturable = "is_capturable"
		case isTradable = "is_tradable"
		case isBattlepet = "is_battlepet"
		case isAllianceOnly = "is_alliance_only"
		case isHordeOnly = "is_horde_only"
		case abilities
		case source
	}
	
	var isCapturableString: String {
		guard let isCapturable = isCapturable else { return L10n.General.unknown }
		return isCapturable ? L10n.General.yes : L10n.General.no
	}
	
	var isTradableString: String {
		guard let isTradable = isTradable else { return L10n.General.unknown }
		return isTradable ? L10n.General.yes : L10n.General.no
	}
	
	var isBattlepetString: String {
		guard let isBattlepet = isBattlepet else { return L10n.General.unknown }
		return isBattlepet ? L10n.General.yes : L10n.General.no
	}
	
	var restrictions: String {
		if let isAllianceOnly = isAllianceOnly, isAllianceOnly {
			return "\(L10n.General.only.lowercased()) \(L10n.General.alliance)"
		} else if let isHordeOnly = isHordeOnly, isHordeOnly {
			return "\(L10n.General.only.lowercased()) \(L10n.General.horde)"
		} else {
			return "-"
		}
	}
	
	func abilities(by slot: Int) -> [PetAbilityModel] {
		abilities?.filter { $0.slot == slot } ?? []
	}
}

struct PetBattleTypeModel: Codable {
	let id: Int?
	let type: String?
	let name: String?
}

struct PetAbilityModel: Codable, Identifiable {
	let ability: NameIdModel?
	let slot: Int?
	let requiredLevel: Int?
	
	var id: Int {
		ability?.id ?? 0
	}
	
	private enum CodingKeys: String, CodingKey {
		case ability
		case slot
		case requiredLevel = "required_level"
	}
}
