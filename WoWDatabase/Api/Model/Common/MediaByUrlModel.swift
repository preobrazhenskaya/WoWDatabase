//
//  MediaByUrlModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct MediaByUrlModel: Codable {
	let key: MediaByUrlKeyModel?
}

struct MediaByUrlKeyModel: Codable {
	let href: String?
}
