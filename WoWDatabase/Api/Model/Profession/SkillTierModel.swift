//
//  SkillTierModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

struct SkillTierModel: Codable {
	let id: Int?
	let name: String?
	let minimumSkillLevel: Int?
	let maximumSkillLevel: Int?
	let categories: [SkillTierCategoriesModel]?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case minimumSkillLevel = "minimum_skill_level"
		case maximumSkillLevel = "maximum_skill_level"
		case categories
	}
	
	var minimumSkillLevelString: String {
		if let minimumSkillLevel = minimumSkillLevel {
			return "\(minimumSkillLevel)"
		} else {
			return "-"
		}
	}
	
	var maximumSkillLevelString: String {
		if let maximumSkillLevel = maximumSkillLevel {
			return "\(maximumSkillLevel)"
		} else {
			return "-"
		}
	}
}

struct SkillTierCategoriesModel: Codable {
	let name: String?
	let recipes: [NameIdModel]?
}
