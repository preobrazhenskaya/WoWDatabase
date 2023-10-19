//
//  AchievementMediaRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Alamofire

struct AchievementMediaRequest: RequestProtocol {
	var endpoint: String {
		"\(Constants.API.URL.media)\(Constants.API.URL.achievement)/\(id)"
	}
	
	let method = HTTPMethod.get
	let parameters = defaultParameters
	let headers = defaultHeaders
	
	typealias Response = MediaModel
	
	let id: Int
}
