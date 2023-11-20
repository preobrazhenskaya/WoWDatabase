//
//  ToyModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct ToyModel: Codable {
	let id: Int?
	let item: NameIdModel?
	let source: TypeNameModel?
	let sourceDescription: String?
	let media: MediaByUrlModel?
	
	enum CodingKeys: String, CodingKey {
		case id
		case item
		case source
		case sourceDescription = "source_description"
		case media
	}
}
