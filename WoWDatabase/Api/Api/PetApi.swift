//
//  PetApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import Alamofire
import Combine

protocol PetApiProtocol {
	func getPetList() -> AnyPublisher<PetListModel, AFError>
	func getPet(id: Int) -> AnyPublisher<PetModel, AFError>
	func getPetMedia(id: Int) -> AnyPublisher<MediaModel, AFError>
	func getPetAbility(id: Int) -> AnyPublisher<AbilityModel, AFError>
	func getPetAbilityMedia(id: Int) -> AnyPublisher<MediaModel, AFError>
}

struct PetApi: PetApiProtocol {
	func getPetList() -> AnyPublisher<PetListModel, AFError> {
		Api.send(request: PetListRequest())
	}
	
	func getPet(id: Int) -> AnyPublisher<PetModel, AFError> {
		Api.send(request: PetRequest(id: id))
	}
	
	func getPetMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: PetMediaRequest(id: id))
	}
	
	func getPetAbility(id: Int) -> AnyPublisher<AbilityModel, AFError> {
		Api.send(request: PetAbilityRequest(id: id))
	}
	
	func getPetAbilityMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: PetAbilityMediaRequest(id: id))
	}
}

struct MockPetApi: PetApiProtocol {
	func getPetList() -> AnyPublisher<PetListModel, AFError> {
		Just(PetListModel(pets: [.init(id: 39, name: "Механическая белка"),
								 .init(id: 40, name: "Бомбейская кошка"),
								 .init(id: 41, name: "Корниш-рекс"),
								 .init(id: 42, name: "Серая полосатая кошка"),
								 .init(id: 43, name: "Рыжая полосатая кошка")]))
			.setFailureType(to: AFError.self)
			.eraseToAnyPublisher()
	}
	
	func getPet(id: Int) -> AnyPublisher<PetModel, AFError> {
		Just(PetModel(id: 39,
					  name: "Механическая белка",
					  battlePetType: .init(id: 9, type: "MECHANICAL", name: "Механизм"),
					  description: "В центре логики механической белки заложены программы сбора как орехов, так и болтов – зимой все пригодится.",
					  isCapturable: false,
					  isTradable: true,
					  isBattlepet: true,
					  isAllianceOnly: false,
					  isHordeOnly: false,
					  abilities: [.init(ability: .init(id: 384, name: "Металлический кулак"), slot: 0, requiredLevel: 1),
								  .init(ability: .init(id: 389, name: "Откалибровка"), slot: 1, requiredLevel: 2),
								  .init(ability: .init(id: 459, name: "Ликвидация"), slot: 2, requiredLevel: 4),
								  .init(ability: .init(id: 202, name: "Взбучка"), slot: 0, requiredLevel: 10),
								  .init(ability: .init(id: 392, name: "Дополнительная броня"), slot: 1, requiredLevel: 15),
								  .init(ability: .init(id: 278, name: "Починка"), slot: 2, requiredLevel: 20)],
					  source: .init(type: "PROFESSION", name: "Профессия")))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getPetMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Just(MediaModel(id: 39,
						assets: [
							.init(key: "icon",
								  value: "https://render.worldofwarcraft.com/us/icons/56/inv_pet_mechanicalsquirrel.jpg",
								  fileDataId: 656559)
						]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getPetAbility(id: Int) -> AnyPublisher<AbilityModel, AFError> {
		Just(AbilityModel(id: 110,
						  name: "Укус",
						  battlePetType: .init(id: 7, type: "BEAST", name: "Животное"),
						  cooldown: 1,
						  rounds: 1))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getPetAbilityMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Just(MediaModel(id: 110,
						assets: [.init(key: "icon",
									   value: "https://render.worldofwarcraft.com/us/icons/56/ability_druid_ferociousbite.jpg",
									   fileDataId: 132127)]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
}
