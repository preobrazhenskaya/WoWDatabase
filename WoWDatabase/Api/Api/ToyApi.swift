//
//  ToyApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import Alamofire
import Combine

protocol ToyApiProtocol {
	func getToyList() -> AnyPublisher<ToyListModel, AFError>
	func getToy(id: Int) -> AnyPublisher<ToyModel, AFError>
	func getToyImage(url: String) -> AnyPublisher<MediaModel, AFError>
}

struct ToyApi: ToyApiProtocol {
	func getToyList() -> AnyPublisher<ToyListModel, AFError> {
		Api.send(request: ToyListRequest())
	}
	
	func getToy(id: Int) -> AnyPublisher<ToyModel, AFError> {
		Api.send(request: ToyRequest(id: id))
	}
	
	func getToyImage(url: String) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: MediaByUrlRequest(imageUrl: url))
	}
}

struct MockToyApi: ToyApiProtocol {
	func getToyList() -> AnyPublisher<ToyListModel, AFError> {
		Just(ToyListModel(toys: [.init(id: 30, name: "Костюм мурлока"),
								 .init(id: 245, name: "Прожектор Тол Барада"),
								 .init(id: 246, name: "Прожектор Тол Барада"),
								 .init(id: 247, name: "Тотем гармонии"),
								 .init(id: 248, name: "\"Ружье\" с тыквенной краской")]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getToy(id: Int) -> AnyPublisher<ToyModel, AFError> {
		Just(ToyModel(id: 245,
					  item: .init(id: 64997, name: "Прожектор Тол Барада"),
					  source: .init(type: "VENDOR", name: "Торговец"),
					  sourceDescription: "Торговец: Погг\nЗона: полуостров Тол Барад\nФракция: батальон Адского Крика – уважение\nЦена: 250",
					  media: .init(key: .init(href: "https://us.api.blizzard.com/data/wow/media/item/64997?namespace=static-10.2.0_51825-us"))))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getToyImage(url: String) -> AnyPublisher<MediaModel, AFError> {
		Just(MediaModel(id: 64997,
						assets: [
							.init(key: "icon",
								  value: "https://render.worldofwarcraft.com/us/icons/56/inv_misc_tolbaradsearchlight.jpg",
								  fileDataId: 462534)
						]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
}
