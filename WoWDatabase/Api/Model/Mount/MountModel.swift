//
//  MountModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.11.2023.
//

struct MountModel: Codable {
	let id: Int?
	let name: String?
	let description: String?
	let source: TypeNameModel?
	let faction: TypeNameModel?
	let requirements: MountRequirementsModel?
	let creatureDisplays: [MountImageModel]?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case description
		case source
		case faction
		case requirements
		case creatureDisplays = "creature_displays"
	}
}

struct MountRequirementsModel: Codable {
	let faction: TypeNameModel?
}

struct MountImageModel: Codable {
	let key: MountImageKeyModel?
}

struct MountImageKeyModel: Codable {
	let href: String?
}
