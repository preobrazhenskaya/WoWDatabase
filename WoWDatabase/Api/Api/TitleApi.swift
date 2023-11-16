//
//  TitleApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

import Alamofire
import Combine

protocol TitleApiProtocol {
	func getTitleList() -> AnyPublisher<TitleListModel, AFError>
	func getTitle(id: Int) -> AnyPublisher<TitleModel, AFError>
}

struct TitleApi: TitleApiProtocol {
	func getTitleList() -> AnyPublisher<TitleListModel, AFError> {
		Api.send(request: TitleListRequest())
	}
	
	func getTitle(id: Int) -> AnyPublisher<TitleModel, AFError> {
		Api.send(request: TitleRequest(id: id))
	}
}

struct MockTitleApi: TitleApiProtocol {
	func getTitleList() -> AnyPublisher<TitleListModel, AFError> {
		Just(TitleListModel(titles: [.init(id: 140, name: "свергнувший Короля"),
									 .init(id: 141, name: "из Пепельного союза"),
									 .init(id: 129, name: "говорящий со звездами"),
									 .init(id: 130, name: "звездный скиталец"),
									 .init(id: 209, name: "Боец")]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getTitle(id: Int) -> AnyPublisher<TitleModel, AFError> {
		Just(TitleModel(id: 122,
						name: "Чудесный",
						genderName: .init(male: "Чудесный {name}", female: "Чудесная {name}"),
						source: .init(achievements: [.init(id: 2798, name: "Чудесный садовник")])))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
}
