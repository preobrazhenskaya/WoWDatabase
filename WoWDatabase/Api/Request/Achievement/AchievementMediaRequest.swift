//
//  AchievementMediaRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

struct AchievementMediaRequest {
	let id: Int
}

extension AchievementMediaRequest: RequestProtocol {
	typealias Response = MediaModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.media)\(Constants.API.URL.achievement)/\(id)"
	}
}
