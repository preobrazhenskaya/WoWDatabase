//
//  AchievementListRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Alamofire

struct AchievementListRequest: RequestProtocol {
	let endpoint = "\(Constants.API.URL.achievement)\(Constants.API.URL.list)"
	let method = HTTPMethod.get
	let parameters = defaultParameters
	let headers = defaultHeaders
	
	typealias Response = AchievementsListModel
}
