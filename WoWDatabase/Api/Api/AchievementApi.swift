//
//  AchievementApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 18.10.2023.
//

import Combine
import Alamofire

protocol AchievementApiProtocol {
	func getAchievementsList() -> AnyPublisher<AchievementsListModel, AFError>
	func getAchievement(id: Int) -> AnyPublisher<AchievementModel, AFError>
	func getAchievementMedia(id: Int) -> AnyPublisher<MediaModel, AFError>
}

struct AchievementApi: AchievementApiProtocol {
	func getAchievementsList() -> AnyPublisher<AchievementsListModel, AFError> {
		Api.send(request: AchievementListRequest())
	}
	
	func getAchievement(id: Int) -> AnyPublisher<AchievementModel, AFError> {
		Api.send(request: AchievementRequest(id: id))
	}
	
	func getAchievementMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: AchievementMediaRequest(id: id))
	}
}

struct MockAchievementApi: AchievementApiProtocol {
	func getAchievementsList() -> AnyPublisher<AchievementsListModel, AFError> {
		Just(AchievementsListModel(achievements: [.init(id: 463, name: "1-й на сервере! Чернокнижник 80-го уровня"),
												  .init(id: 293, name: "Дебошир"),
												  .init(id: 1254, name: "Друг или индюк?"),
												  .init(id: 1291, name: "Вам одиноко?"),
												  .init(id: 545, name: "Пожалуйте бриться!")]))
			.setFailureType(to: AFError.self)
			.eraseToAnyPublisher()
	}
	
	func getAchievement(id: Int) -> AnyPublisher<AchievementModel, AFError> {
		Just(AchievementModel(id: 608,
							  category: .init(id: 160, name: "Лунный фестиваль"),
							  name: "25 монет наследия",
							  description: "Соберите 25 монет наследия.",
							  points: 10,
							  isAccountWide: false,
							  criteria: .init(id: 1818,
											  childCriteria: [.init(id: 1819, description: "Собрать 25 монет наследия")]),
							  prerequisiteAchievement: .init(id: 607, name: "10 монет наследия"),
							  nextAchievement: .init(id: 609, name: "50 монет наследия"),
							  rewardDescription: nil,
							  requirements: nil))
			.setFailureType(to: AFError.self)
			.eraseToAnyPublisher()
	}
	
	func getAchievementMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Just(MediaModel(id: 608,
						assets: [.init(key: "icon",
									   value: "https://render.worldofwarcraft.com/eu/icons/56/inv_misc_elvencoins.jpg",
									   fileDataId: 133858)]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
}
