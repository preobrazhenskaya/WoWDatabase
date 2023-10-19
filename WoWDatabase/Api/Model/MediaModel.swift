//
//  MediaModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

struct MediaModel: Codable {
	let id: Int?
	let assets: [MediaAssetModel]?
}

struct MediaAssetModel: Codable {
	let key: String?
	let value: String?
	let fileDataId: Int?
	
	private enum CodingKeys: String, CodingKey {
		case key
		case value
		case fileDataId = "file_data_id"
	}
}
