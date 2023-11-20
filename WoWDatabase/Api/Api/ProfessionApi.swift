//
//  ProfessionApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Alamofire
import Combine

protocol ProfessionApiProtocol {
	func getProfessionsList() -> AnyPublisher<ProfessionsListModel, AFError>
	func getProfession(id: Int) -> AnyPublisher<ProfessionModel, AFError>
	func getProfessionMedia(id: Int) -> AnyPublisher<MediaModel, AFError>
	func getSkillTier(professionId: Int, skillTierId: Int) -> AnyPublisher<SkillTierModel, AFError>
	func getRecipe(id: Int) -> AnyPublisher<RecipeModel, AFError>
	func getRecipeMedia(id: Int) -> AnyPublisher<MediaModel, AFError>
	func getItem(id: Int) -> AnyPublisher<ItemModel, AFError>
	func getItemMedia(id: Int) -> AnyPublisher<MediaModel, AFError>
}

struct ProfessionApi: ProfessionApiProtocol {
	func getProfessionsList() -> AnyPublisher<ProfessionsListModel, AFError> {
		Api.send(request: ProfessionsListRequest())
	}
	
	func getProfession(id: Int) -> AnyPublisher<ProfessionModel, AFError> {
		Api.send(request: ProfessionRequest(id: id))
	}
	
	func getProfessionMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: ProfessionMediaRequest(id: id))
	}
	
	func getSkillTier(professionId: Int, skillTierId: Int) -> AnyPublisher<SkillTierModel, AFError> {
		Api.send(request: SkillTierRequest(professionId: professionId, skillTierId: skillTierId))
	}
	
	func getRecipe(id: Int) -> AnyPublisher<RecipeModel, AFError> {
		Api.send(request: RecipeRequest(id: id))
	}
	
	func getRecipeMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: RecipeMediaRequest(id: id))
	}
	
	func getItem(id: Int) -> AnyPublisher<ItemModel, AFError> {
		Api.send(request: ItemRequest(id: id))
	}
	
	func getItemMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: ItemMediaRequest(id: id))
	}
}

struct MockProfessionApi: ProfessionApiProtocol {
	func getProfessionsList() -> AnyPublisher<ProfessionsListModel, AFError> {
		Just(ProfessionsListModel(professions: [.init(id: 202, name: "Инженерное дело"),
												.init(id: 393, name: "Снятие шкур"),
												.init(id: 164, name: "Кузнечное дело"),
												.init(id: 333, name: "Наложение чар"),
												.init(id: 182, name: "Травничество")]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getProfession(id: Int) -> AnyPublisher<ProfessionModel, AFError> {
		Just(ProfessionModel(id: 202,
							 name: "Инженерное дело",
							 description: "Чем лучше развит этот навык, тем более сложные инженерные чертежи вы можете использовать. Чертежи можно найти у учителей, а также получить в качестве добычи или награды.",
							 type: .init(name: "Основное"),
							 skillTiers: [.init(id: 2499,
												name: "Кул-тирасское инженерное дело / Зандаларское инженерное дело"),
										  .init(id: 2500, name: "Инженерное дело Legion"),
										  .init(id: 2501, name: "Инженерное дело Дренора"),
										  .init(id: 2502, name: "Инженерное дело Пандарии"),
										  .init(id: 2503, name: "Инженерное дело времен Катаклизма")]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getProfessionMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Just(MediaModel(id: 202,
						assets: [.init(key: "icon",
									   value: "https://render.worldofwarcraft.com/us/icons/56/ui_profession_engineering.jpg",
									   fileDataId: 4620673)]))
			.setFailureType(to: AFError.self)
			.eraseToAnyPublisher()
	}
	
	func getSkillTier(professionId: Int, skillTierId: Int) -> AnyPublisher<SkillTierModel, AFError> {
		Just(SkillTierModel(id: 2499,
							name: "Кул-тирасское инженерное дело / Зандаларское инженерное дело",
							minimumSkillLevel: 1,
							maximumSkillLevel: 175,
							categories: [.init(name: "Оружие",
											   recipes: [.init(id: 38932,
															   name: "Точно настроенный уничтожатор из штормовой стали"),
														 .init(id: 38933,
															   name: "Точно настроенный уничтожатор из штормовой стали"),
														 .init(id: 38934,
															   name: "Точно настроенный уничтожатор из штормовой стали")]),
										 .init(name: "Устройства",
											   recipes: [.init(id: 38919,
															   name: "\"Турбопосудина XA-1000\""),
														 .init(id: 38920,
															   name: "\"Турбопосудина XA-1000\""),
														 .init(id: 38921,
															   name: "\"Турбопосудина XA-1000\"")])]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getRecipe(id: Int) -> AnyPublisher<RecipeModel, AFError> {
		Just(RecipeModel(id: 38932,
						 name: "Точно настроенный уничтожатор из штормовой стали",
						 description: "Изготовить точно настроенный уничтожатор из штормовой стали.",
						 craftedItem: nil,
						 allianceCraftedItem: .init(id: 161930, name: "Точно настроенный уничтожатор из штормовой стали"),
						 hordeCraftedItem: .init(id: 153506, name: "Точно настроенный уничтожатор из штормовой стали"),
						 reagents: [.init(reagent: .init(id: 152579, name: "Руда штормового серебра"), quantity: 25),
									.init(reagent: .init(id: 152513, name: "Платиновая руда"), quantity: 12),
									.init(reagent: .init(id: 160502, name: "Химический запал"), quantity: 5),
									.init(reagent: .init(id: 152668, name: "Дистиллиум"), quantity: 8)],
						 rank: 1,
						 craftedQuantity: .init(value: 1)))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getRecipeMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Just(MediaModel(id: 38932,
						assets: [.init(key: "icon",
									   value: "https://render.worldofwarcraft.com/us/icons/56/trade_engineering.jpg",
									   fileDataId: 136243)]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
	
	func getItem(id: Int) -> AnyPublisher<ItemModel, AFError> {
		Just(ItemModel(id: 161930,
					   name: "Точно настроенный уничтожатор из штормовой стали",
					   quality: .init(type: "RARE", name: "Редкое"),
					   level: 59,
					   itemClass: .init(id: 2, name: "Оружие"),
					   itemSubclass: .init(id: 3, name: "Огнестрельное"),
					   inventoryType: .init(type: "RANGEDRIGHT", name: "Оружие дальнего боя"),
					   description: "Жарогенерирующее устройство нейтрализации. Нейтрализует противников, а также раздражающие запахи.",
					   previewItem: .init(binding: .init(type: "ON_EQUIP", name: "Становится персональным при надевании"),
										  weapon: .init(damage: .init(displayString: "Урон: 19"),
														attackSpeed: .init(displayString: "Скорость 3,00"),
														dps: .init(displayString: "(6,3 ед. урона в секунду)")),
										  armor: .init(display: .init(displayString: "Броня: 10")),
										  stats: [.init(display: .init(displayString: "+9 к ловкости")),
												  .init(display: .init(displayString: "+13 к выносливости"))],
										  spells: [.init(description: "Если на персонаже: Повышает навык кул-тирасского или зандаларского инженерного дела на 20.")],
										  sellPrice: .init(displayStrings: .init(header: "Цена продажи:",
																				 gold: "0",
																				 silver: "48",
																				 copper: "58")),
										  requirements: .init(level: .init(displayString: "Требуется 50-й уровень"),
															  skill: .init(displayString: "Требуется: Кул-тирасское инженерное дело (1)"),
															  reputation: .init(displayString: "Требуется: Уважение со стороны батальона Адского Крика")),
										  durability: .init(displayString: "Прочность: 100 / 100"))))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}

	func getItemMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Just(MediaModel(id: 161930,
						assets: [.init(key: "icon",
									   value: "https://render.worldofwarcraft.com/eu/icons/56/inv_firearm_2h_rifle_kultirasquest_b_01.jpg",
									   fileDataId: 1773651)]))
		.setFailureType(to: AFError.self)
		.eraseToAnyPublisher()
	}
}
