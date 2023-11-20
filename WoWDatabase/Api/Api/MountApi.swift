//
//  MountApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.11.2023.
//

import Alamofire
import Combine

protocol MountApiProtocol {
	func getMountList() -> AnyPublisher<MountListModel, AFError>
	func getMount(id: Int) -> AnyPublisher<MountModel, AFError>
	func getMountImage(url: String) -> AnyPublisher<MediaModel, AFError>
}

struct MountApi: MountApiProtocol {
	func getMountList() -> AnyPublisher<MountListModel, AFError> {
		Api.send(request: MountListRequest())
	}
	
	func getMount(id: Int) -> AnyPublisher<MountModel, AFError> {
		Api.send(request: MountRequest(id: id))
	}
	
	func getMountImage(url: String) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: MountImageRequest(imageUrl: url))
	}
}

struct MockMountApi: MountApiProtocol {
	func getMountList() -> AnyPublisher<MountListModel, AFError> {
		Just(MountListModel(mounts: [.init(id: 6, name: "Гнедой конь"),
									 .init(id: 7, name: "Серый волк"),
									 .init(id: 8, name: "Белый жеребец"),
									 .init(id: 9, name: "Вороной жеребец"),
									 .init(id: 11, name: "Пегий конь")]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getMount(id: Int) -> AnyPublisher<MountModel, AFError> {
		Just(MountModel(id: 6,
						name: "Гнедой конь",
						description: "Стражи Штормграда любят их за терпение и выносливость.",
						source: .init(type: "VENDOR", name: "Торговец"),
						faction: .init(type: "ALLIANCE", name: "Альянс"),
						requirements: .init(faction: .init(type: "ALLIANCE", name: "Альянс")),
						creatureDisplays: [.init(key: .init(href: "https://eu.api.blizzard.com/data/wow/media/creature-display/113665?namespace=static-10.2.0_51825-eu"))]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getMountImage(url: String) -> AnyPublisher<MediaModel, AFError> {
		Just(MediaModel(id: nil,
						assets: [.init(key: "zoom",
									   value: "https://render.worldofwarcraft.com/us/npcs/zoom/creature-display-2404.jpg",
									   fileDataId: nil)]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
}
