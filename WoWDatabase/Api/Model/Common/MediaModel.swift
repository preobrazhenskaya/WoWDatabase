//
//  MediaModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Foundation

struct MediaModel: Codable {
	let id: Int?
	let assets: [MediaAssetModel]?
	
	var iconUrl: URL? {
		URL(string: assets?.first?.value ?? "")
	}
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
