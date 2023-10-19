//
//  AchievementRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Alamofire

struct AchievementRequest {
	let id: Int
}

extension AchievementRequest: RequestProtocol {
	typealias Response = AchievementModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.achievement)/\(id)"
	}
}
