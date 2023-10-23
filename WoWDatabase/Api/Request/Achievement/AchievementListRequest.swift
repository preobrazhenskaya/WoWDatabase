//
//  AchievementListRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

struct AchievementListRequest: RequestProtocol {
	typealias Response = AchievementsListModel
	let url = "\(Constants.API.URL.main)\(Constants.API.URL.achievement)\(Constants.API.URL.list)"
}
