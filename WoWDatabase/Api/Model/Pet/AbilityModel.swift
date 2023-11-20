//
//  AbilityModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct AbilityModel: Codable {
	let id: Int?
	let name: String?
	let battlePetType: PetBattleTypeModel?
	let cooldown: Int?
	let rounds: Int?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case battlePetType = "battle_pet_type"
		case cooldown
		case rounds
	}
}
