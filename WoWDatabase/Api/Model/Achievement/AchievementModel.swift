//
//  AchievementModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 29.09.2023.
//

struct AchievementModel: Codable {
	let id: Int?
	let category: AchievementCategoryModel?
	let name: String?
	let description: String?
	let points: Int?
	let isAccountWide: Bool?
	let criteria: AchievementCriteriaModel?
	let prerequisiteAchievement: AchievementShortModel?
	let nextAchievement: AchievementShortModel?
	let rewardDescription: String?
	let requirements: AchievementRequirementsModel?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case category
		case name
		case description
		case points
		case isAccountWide = "is_account_wide"
		case criteria
		case prerequisiteAchievement = "prerequisite_achievement"
		case nextAchievement = "next_achievement"
		case rewardDescription = "reward_description"
		case requirements
	}
	
	var pointsString: String {
		if let points = points {
			return "\(points)"
		} else {
			return "-"
		}
	}
	
	var isAccountWideString: String {
		if let isAccountWide = isAccountWide {
			return isAccountWide ? L10n.General.yes : L10n.General.no
		} else {
			return "-"
		}
	}
}

struct AchievementCategoryModel: Codable {
	let id: Int?
	let name: String?
}

struct AchievementCriteriaModel: Codable {
	let id: Int?
	let childCriteria: [AchievementChildCriteriaModel]?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case childCriteria = "child_criteria"
	}
}

struct AchievementChildCriteriaModel: Codable, Identifiable {
	let id: Int?
	let description: String?
}

struct AchievementRequirementsModel: Codable {
	let faction: AchievementRequirementsFactionModel?
}

struct AchievementRequirementsFactionModel: Codable {
	let type: String?
	let name: String?
}
