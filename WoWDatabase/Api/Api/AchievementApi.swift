//
//  AchievementApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 18.10.2023.
//

import Combine
import Alamofire

struct AchievementApi {
	static func getAchievementsList() -> AnyPublisher<AchievementsListModel, AFError> {
		Api.send(request: AchievementListRequest())
	}
	
	static func getAchievement(id: Int) -> AnyPublisher<AchievementModel, AFError> {
		Api.send(request: AchievementRequest(id: id))
	}
	
	static func getAchievementMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: AchievementMediaRequest(id: id))
	}
}
