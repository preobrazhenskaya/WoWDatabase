//
//  ProfessionModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

struct ProfessionModel: Codable {
	let id: Int?
	let name: String?
	let description: String?
	let type: ProfessionTypeModel?
	let skillTiers: [NameIdModel]?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case description
		case type
		case skillTiers = "skill_tiers"
	}
}

struct ProfessionTypeModel: Codable {
	let name: String?
}
