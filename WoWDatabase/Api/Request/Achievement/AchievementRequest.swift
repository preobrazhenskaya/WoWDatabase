//
//  AchievementRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Alamofire

struct AchievementRequest: RequestProtocol {
	var endpoint: String {
		"\(Constants.API.URL.achievement)/\(id)"
	}
	
	let method = HTTPMethod.get
	let parameters = defaultParameters
	let headers = defaultHeaders
	
	typealias Response = AchievementModel
	
	let id: Int
}
