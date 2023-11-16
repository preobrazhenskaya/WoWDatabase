//
//  TitleModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

struct TitleModel: Codable {
	let id: Int?
	let name: String?
	let genderName: TitleGenderNameModel?
	let source: TitleSourceModel?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case genderName = "gender_name"
		case source
	}
}

struct TitleGenderNameModel: Codable {
	let male: String?
	let female: String?
}

struct TitleSourceModel: Codable {
	let achievements: [NameIdModel]?
}
